//
//  Router.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

class Router {
    
    weak var presenter: HeadlineViewToPresenterProtocol?
    
    func headlineView() -> HeadlinesViewController {
        let headlineVC = HeadlinesViewController.init(type: .Headlines)
        headlineVC.presenter = presenter
        print("Head")
        return headlineVC
    }
    
    func countryView() -> CountryViewController {
        let countryVC = CountryViewController.init()
        countryVC.presenter = presenter
        return countryVC
    }
    
    func searchView() -> SearchViewController {
        let searchVC = SearchViewController.init()
        searchVC.presenter = presenter
        return searchVC
    }
    
    func getExpandedNews(content: String?) -> ExpandedNews {
        let newsVC = ExpandedNews.init()
        newsVC.contentLabel.text = content
        newsVC.modalPresentationStyle = .formSheet
        return newsVC
    }
    
}
