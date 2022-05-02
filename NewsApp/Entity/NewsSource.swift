//
//  NewsSource.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 02/05/22.
//

import Foundation

struct Source: Codable {
    var id: String?
    var name:String?
}

struct NewsSource: Codable {
    var sources: [Source]?
}
