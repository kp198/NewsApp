//
//  Headline.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation

enum HeadlinesType {
    case Headlines
    case Country
    case Search
    case NewsSource
}

struct Article: Codable {
    var articles: [Headline]
    var totalResults: Int?
}

struct Headline: Codable {
    var author: String?
    var content: String?
    var description: String?
    var url: String?
    var title: String?
    var publishedAt: String?
    var urlToImage: String?
}
