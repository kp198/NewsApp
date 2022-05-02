//
//  ExpandedNews.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

class ExpandedNews: UIViewController {
    let contentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentLabel()
        self.view.backgroundColor = .white
    }
    
    func setupContentLabel() {
        self.view.addSubview(contentLabel)
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([contentLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),contentLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor), contentLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.75), contentLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75)])
    }
}
