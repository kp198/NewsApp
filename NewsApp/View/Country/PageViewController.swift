//
//  PageViewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

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
