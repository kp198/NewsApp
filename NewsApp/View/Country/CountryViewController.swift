//
//  CountryViewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

class CountryViewController: UIViewController {
    let table = UITableView()
    let countriesList = [["India":"in"],["USA":"us"],["Canada":"ca"],["China":"cn"]]
    var presenter: HeadlineViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupCountries()
    }
    
    func setupCountries() {
        setUpTable()
    }
    
    func setUpTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.setUpTableInViewController(table: table)
        self.table.delegate = self
        self.table.dataSource = self
    }
}

extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countriesList[indexPath.row].first?.key
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let country = HeadlinesViewController.init(type: .Country, country: countriesList[indexPath.row].first?.value ?? "in", news: nil)
//        country.presenter = self.presenter
//        self.present(country, animated: true)
        let topCtrl = TopTabController.init(country: countriesList[indexPath.row].first?.value ?? "in")
        topCtrl.presenter = presenter
        self.present(topCtrl, animated: true)
    }
}

class TopTabController: UIPageViewController {
    let countryHeadlines: HeadlinesViewController
    weak var presenter: HeadlineViewToPresenterProtocol? {
        didSet {
            self.countryHeadlines.presenter = presenter
            self.sources.presenter = presenter as? SourceToPresenter
        }
    }
    let country: String?
    let sources:SourcesViewController
    
    init( country: String?) {
        self.country = country
        self.countryHeadlines = HeadlinesViewController.init(type: .Country, country: country, news: nil)
        self.sources = SourcesViewController.init(country: country ?? "in")
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        countryHeadlines.view.backgroundColor = .red
        sources.view.backgroundColor = .gray
        
        topTabSetup()
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([countryHeadlines], direction: .forward, animated: true)
    }
    
    func topTabSetup() {
        let topHeadlines = UIButton.init()
        self.view.addSubview(topHeadlines)
        topHeadlines.translatesAutoresizingMaskIntoConstraints = false
        let sources = UIButton.init()
        self.view.addSubview(sources)
        sources.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topHeadlines.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 20), topHeadlines.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5), topHeadlines.heightAnchor.constraint(equalToConstant: 40), topHeadlines.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)])
        
        NSLayoutConstraint.activate([sources.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 20), sources.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5), sources.heightAnchor.constraint(equalToConstant: 40), sources.leadingAnchor.constraint(equalTo: topHeadlines.trailingAnchor)])
    }
    
    
}

extension TopTabController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let vc = UIViewController.init()
//        vc.view.backgroundColor = .red
        if viewController == countryHeadlines {
            return sources
        }
        return countryHeadlines
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == countryHeadlines {
            return sources
        }
        return countryHeadlines
    }
}

struct Source: Codable {
    var id: String?
    var name:String?
}

struct NewsSource: Codable {
    var sources: [Source]?
}

protocol SourceToPresenter: AnyObject {
    func getSourceList(parameters: [String:String],completion: @escaping([Source], Error?)->Void)
}


class SourcesViewController: UIViewController {
    let table = UITableView.init()
    let country: String
    weak var presenter: SourceToPresenter? {
        didSet {
            fetchSources()
        }
    }
    var newsSources: [Source]?
    
    init(country: String) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    func setUpTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.setUpTableInViewController(table: table)
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    func fetchSources() {
        presenter?.getSourceList(parameters: ["country":country], completion: {
            sources,_ in
            self.newsSources = sources
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        })
    }
}

extension SourcesViewController: UITableViewDataSource, UITableViewDelegate, HeadlinePresenterToViewProtocol {
    
    func present(viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsSources?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        cell.textLabel?.text = newsSources?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let headlines = HeadlinesViewController.init(type: .NewsSource, country: nil, news: newsSources?[indexPath.row].id)
        headlines.presenter = self.presenter as? HeadlineViewToPresenterProtocol
        headlines.presenter?.viewDelegate = self
        self.present(headlines, animated: true)
    }
}
