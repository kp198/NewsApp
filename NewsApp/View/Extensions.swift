//
//  Extensions.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 01/05/22.
//

import UIKit

extension UIViewController {
    
    func setUpTableInViewController(table: UITableView) {
        self.view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([table.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 10), table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10), table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10), table.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor)])
    }
    
}

