//
//  ViewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 30/04/22.
//

import UIKit

class NewsTabViewController: UITabBarController {

    let router = Router.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.viewControllers = [router.headlineView(), Countries.init(), Search.init()]
        setUpTabbarItems()
    }
    
    func setUpTabbarItems() {
        let titles = ["Headlines","Countries","Search"]
        for (i, vc) in (self.viewControllers ?? []).enumerated() {
            let tabItem = UITabBarItem.init(title: titles[i], image: nil, selectedImage: nil)
            vc.tabBarItem = tabItem
        }
    }
}

protocol HeadlineViewToPresenter: AnyObject {
    func fetchHeadlines(page: Int,completion: @escaping(Article, Error?)->Void)
}



class HeadlinesViewController: UIViewController {
    
    var presenter: HeadlineViewToPresenter?
    var headlines: [Headline]? {
        didSet {
            print("didSet",headlines?.count)
        }
    }
    let table = UITableView.init()
    private var totalRes = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        self.setUpTable()
        print("Yesss")
        self.fetchHeadlines()
    }
    
    func setUpTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(LoadingCell.self, forCellReuseIdentifier: "loading")
        self.setUpTableInViewController(table: table)
        self.table.delegate = self
        self.table.dataSource = self
        self.table.prefetchDataSource = self
    }
    
    func fetchHeadlines() {
        presenter?.fetchHeadlines(page: ((headlines?.count ?? 0)/20+1), completion: { [weak self]
            articles, err in
            self?.totalRes = articles.totalResults ?? self?.totalRes ?? 20
            print(articles.articles.count,self?.headlines?.count,"Niiiii")// self?.articles.articles.count,self?.headlines?.count,"Niiiii")
            if self?.headlines == nil {
                self?.headlines = []
            }
            self?.headlines?.append(contentsOf: articles.articles)
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        })
    }
}

extension HeadlinesViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
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
            DispatchQueue.global().asyncAfter(deadline: .now()+10, execute: {
                self.fetchHeadlines()
            })
        }
    }
    
}


class Countries: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}


class Search: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
