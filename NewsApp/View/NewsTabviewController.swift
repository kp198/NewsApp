//
//  NewsTabviewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

class NewsTabViewController: UITabBarController {

    let presenter = HeadlinePresenter.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbarItems()
        
        setupTabViewControllers()
    }
    
    func setupTabViewControllers() {
        self.viewControllers = [presenter.getHeadlineView(),presenter.getCountryView(), presenter.getSearchView()]
    }
    
    func setUpTabbarItems() {
        let titles = ["Headlines","Countries","Search"]
        let images = ["clock","network","magnifyingglass"]
        for (i, vc) in (self.viewControllers ?? []).enumerated() {
            let tabItem = UITabBarItem.init(title: titles[i], image: UIImage.init(systemName: images[i]), selectedImage: UIImage.init(systemName: images[i]))
            vc.tabBarItem = tabItem
        }
    }
}
