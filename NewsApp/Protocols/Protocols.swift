//
//  Protocols.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation
import UIKit

protocol HeadlineViewToPresenterProtocol: AnyObject {
    var viewDelegate: HeadlinePresenterToViewProtocol? {get set}
    func fetchHeadlines(parameters: [String:String],completion: @escaping(Article?, Error?)->Void)
    func showExpandedNews(content: String?)
    func fetchSearchFrom(parameters: [String:String],completion: @escaping (Article?, Error?) -> Void)
}

protocol HeadlinePresenterToViewProtocol: AnyObject {
    func present(viewController: UIViewController)
}

protocol TableToViewControllerProtocol: AnyObject {
    func getSearchText() -> String
}


protocol SourceToPresenter: AnyObject {
    func getSourceList(parameters: [String:String],completion: @escaping([Source]?, Error?)->Void)
}
