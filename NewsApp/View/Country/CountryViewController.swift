//
//  CountryViewController.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

class CountryViewController: UIViewController {
    let table = UITableView()
    let countriesList = [["India":"in"],["USA":"us"],["Canada":"ca"],["China":"cn"]]
    var presenter: HeadlineViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCountries()
    }
    
    func setupCountries() {
        setUpTable()
    }
    
    func setUpTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.setUpTableInViewController(table: table)
        self.table.delegate = self
        self.table.dataSource = self
    }
}

extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countriesList[indexPath.row].first?.key
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let country = HeadlinesViewController.init(type: .Country, country: countriesList[indexPath.row].first?.value ?? "in", news: nil)
//        country.presenter = self.presenter
//        self.present(country, animated: true)
        let topCtrl = TopTabController.init(country: countriesList[indexPath.row].first?.value ?? "in")
        topCtrl.presenter = presenter
        self.present(topCtrl, animated: true)
    }
}
