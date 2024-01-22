//
//  GetGitHubDataRequest.swift
//  SaveRepo
//
//  Created by A1398 on 11/01/2023.
//

import Foundation

struct GetGitHubDataRequest: RequestProtocol {
    private let beginUrlString = "https://api.github.com/search/repositories?q="
    private let endUrlString = "&sort=stars&order=desc"
    private let language : String
    private let title : String
    private let method: String = "GET"
    
    init(title: String, language: String) {
        self.title = title
        self.language = language
    }

    var urlRequest: URLRequest {
        let urlString = "\(beginUrlString)\(title)+language:\(language)\(endUrlString)"
        let url: URL = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
