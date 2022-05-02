//
//  HeadlinePresenter.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 01/05/22.
//

import Foundation


class HeadlinePresenter:HeadlineViewToPresenterProtocol, SourceToPresenter {
    
    
    let router = Router.init()
    let networkReq = NetworkRequest.init()
    weak var viewDelegate: HeadlinePresenterToViewProtocol?
    
    
    init() {
        router.presenter = self
    }
    
    func fetchHeadlines(parameters: [String:String],completion: @escaping (Article?, Error?) -> Void) {
        networkReq.sendRequest(urlStr: "https://newsapi.org/v2/top-headlines", parameters: parameters, method: .get, codableClass: Article.self, completion: completion)
    }
    
    func fetchSearchFrom(parameters: [String:String],completion: @escaping (Article?, Error?) -> Void) {
        networkReq.sendRequest(urlStr: "https://newsapi.org/v2/everything", parameters: parameters, method: .get, codableClass: Article.self, completion: completion)
    }
    
    func getHeadlineView() -> HeadlinesViewController {
        return router.headlineView()
    }
    
    func getCountryView() -> CountryViewController {
        return router.countryView()
    }
    
    func getSearchView() -> SearchViewController {
        return router.searchView()
    }
    
    func showExpandedNews(content: String?) {
        viewDelegate?.present(viewController: router.getExpandedNews(content: content))
    }
    
    func getSourceList(parameters: [String:String],completion: @escaping([Source]?, Error?) -> Void) {
        networkReq.sendRequest(urlStr: "https://newsapi.org/v2/top-headlines/sources",parameters: parameters, method: .get, codableClass: NewsSource.self, completion: {
            newsSource, err in
            completion(newsSource?.sources ?? [],err)
        })
    }
}
