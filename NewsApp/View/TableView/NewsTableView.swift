//
//  NewsTableView.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

class NewsTableView: UITableView {
    
    var presenter: HeadlineViewToPresenterProtocol? {
        didSet {
            fetchHeadlines()
        }
    }
    
    var headlines: [Headline]? {
        didSet {
            print("didSet",headlines?.count)
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    var searchText: String? {
        didSet {
            fetchHeadlines()
        }
    }
    
    private var totalRes = Int()
    private let type: HeadlinesType
    private let country: String?
    private let news: String?
    
    
    init(type: HeadlinesType, country: String? = "in", news: String? = nil) {
        
        self.country = country
        self.news = news
        self.type = type
        super.init(frame: .zero, style: .plain)
        self.delegate = self
        self.dataSource = self
        self.prefetchDataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constructParamList() -> [String:String] {
        
        let page = ((headlines?.count ?? 0)/20+1)
        var params = [String:String]()
        params["page"] = "\(page)"
        if type == .Search, searchText != nil {
            params["q"] = searchText!
        } else {
            if news != nil {
                params["sources"] = news
            }
            if country != nil {
                params["country"] = country
            }
        }
        return params
    }
    
    func fetchHeadlines() {
        presenter?.fetchHeadlines(parameters: constructParamList(), completion: { [weak self]
            articles, err in
            self?.totalRes = articles.totalResults ?? self?.totalRes ?? 20
            print(articles.articles.count,self?.headlines?.count,"Niiiii")// self?.articles.articles.count,self?.headlines?.count,"Niiiii")
            if self?.headlines == nil || self?.type == .Search {
                self?.headlines = []
            }
            self?.headlines?.append(contentsOf: articles.articles)
            
        })
    }
    
    func fetchSearchFrom() {
        presenter?.fetchSearchFrom(parameters: constructParamList(), completion: { [weak self]
            articles, err in
            self?.totalRes = articles.totalResults ?? self?.totalRes ?? 20
            if self?.headlines == nil {
                self?.headlines = []
            }
            self?.headlines?.append(contentsOf: articles.articles)
            DispatchQueue.main.async {
                self?.reloadData()
            }
        })
    }
}

extension NewsTableView: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (headlines?.count ?? 0) != totalRes ? (headlines?.count ?? 0)+1 : (headlines?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if headlines != nil, indexPath.row == headlines?.count && indexPath.row != totalRes {
            let lcell = LoadingCell.init(style: .default, reuseIdentifier: "loading")
            lcell.activityIndicator.startAnimating()
            return lcell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = headlines?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        print(indexPaths)
        let last = (indexPaths.last ?? IndexPath()).row
        if headlines != nil, last == headlines!.count && headlines!.count < totalRes {
//            DispatchQueue.global().asyncAfter(deadline: .now()+10, execute: {
                self.fetchHeadlines()
//            })
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showExpandedNews(content: headlines?[indexPath.row].content)
    }
    
}
