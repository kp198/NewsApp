//
//  SourcesViewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

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
