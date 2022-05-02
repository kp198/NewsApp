//
//  LoadingCell.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

class LoadingCell: UITableViewCell {
    
    let activityIndicator = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoading() {
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor), activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor), activityIndicator.widthAnchor.constraint(equalToConstant: 40), activityIndicator.heightAnchor.constraint(equalToConstant: 40)])
        
    }
}
