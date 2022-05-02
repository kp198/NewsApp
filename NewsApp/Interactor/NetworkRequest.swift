//
//  NetworkRequest.swift
//  NewsApp
//
//  Created by Keerthika Priya G on 30/04/22.
//

import Foundation

enum HttpMethod:String {
    case get
    case post
}

class NetworkRequest {
    
    
   static func sendRequest(urlStr: String, parameters: [String:String]? = nil, method: HttpMethod, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let apiKey = "f5ba7d67e5ae4824853660e33d45f886"
        guard var urlComponents = URLComponents.init(string: urlStr) else {return}
        if parameters != nil && parameters!.isEmpty {
            urlComponents.queryItems = [URLQueryItem.init(name: "apiKey", value: apiKey)]
        }
        for param in parameters ?? [:] {
            urlComponents.queryItems?.append(URLQueryItem.init(name: param.key, value: param.value))
        }
        URLSession.shared.dataTask(with: urlComponents.url!,completionHandler: completion).resume()
    }
    
    func sendRequest<T:Codable>(urlStr: String, parameters: [String:String]? = nil, method: HttpMethod,codableClass: T.Type, completion: @escaping(T, Error?) -> Void) {
         let apiKey = "f5ba7d67e5ae4824853660e33d45f886"
         guard var urlComponents = URLComponents.init(string: urlStr) else {return}
        urlComponents.queryItems = [URLQueryItem.init(name: "apiKey", value: apiKey)]
         for param in parameters ?? [:] {
             urlComponents.queryItems?.append(URLQueryItem.init(name: param.key, value: param.value))
         }
         URLSession.shared.dataTask(with: urlComponents.url!,completionHandler: {
             data, response, err in
               let decoder = JSONDecoder.init()
             if let data = data ,
                let decoded = try? decoder.decode(T.self, from: data) {
                 completion(decoded,nil)
             }
            
         }).resume()
     }
}
