//
//  ViewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 30/04/22.
//

import UIKit

class NewsTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.viewControllers = []
        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        super.tabBar(tabBar, didSelect: item)
        
    }


}

class Headlines: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
