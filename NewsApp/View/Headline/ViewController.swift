//
//  ViewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 30/04/22.
//

import UIKit


class HeadlinesViewController: UIViewController {
   
    var presenter: HeadlineViewToPresenterProtocol? {
        didSet {
            table.presenter = presenter
            presenter?.viewDelegate = self
        }
    }
    
    let table: NewsTableView
    
    init(type: HeadlinesType, country: String? = "in", news: String? = nil) {
        self.table = NewsTableView.init(type: type, country: country, news: news)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        self.setUpTable()
    }
    
    
    func setUpTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(LoadingCell.self, forCellReuseIdentifier: "loading")
        self.setUpTableInViewController(table: table)
    }
}

extension HeadlinesViewController: HeadlinePresenterToViewProtocol {
    func present(viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
}
