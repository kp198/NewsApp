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
    let pageControl = UIPageControl.init()
    
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
        
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([countryHeadlines], direction: .forward, animated: true)
        
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        NSLayoutConstraint.activate([pageControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10), pageControl.heightAnchor.constraint(equalToConstant: 20), pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)])
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.pageIndicatorTintColor = .lightGray
        
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let vc = pageViewController.viewControllers?.first {
                pageControl.currentPage = (vc as? HeadlinesViewController != nil) ? 0 : 1
            }
        }
    }
}
