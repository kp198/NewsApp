//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    let table: NewsTableView
    let searchBar = UISearchBar.init()
    var presenter: HeadlineViewToPresenterProtocol? {
        didSet {
            table.presenter = presenter
            table.presenter?.viewDelegate = self
        }
    }
    
    init() {
        table = NewsTableView.init(type: .Search, country: nil, news: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpSearch()
        setUpTable()
    }
    
    func setUpSearch() {
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 20), searchBar.heightAnchor.constraint(equalToConstant: 30), searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)])
        searchBar.delegate = self
    }
    
    func setUpTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(LoadingCell.self, forCellReuseIdentifier: "loading")
        self.view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .gray
        NSLayoutConstraint.activate([table.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 10), table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10), table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10), table.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor)])
    }
    
}

extension SearchViewController: UISearchBarDelegate, HeadlinePresenterToViewProtocol {
    func present(viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        table.searchText = searchBar.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            table.headlines = nil
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        table.headlines = nil
    }
}
