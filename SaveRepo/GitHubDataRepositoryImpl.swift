//
//  GitHubDataRepositoryImpl.swift
//  SaveRepo
//
//  Created by A1398 on 16/01/2023.
//

import Foundation

protocol GithubDataRepositoryProtocol {
    func getGitHubData(title: String, language: String, completion: @escaping (Result<GitHubData, Error>)-> Void)
}

final class GitHubDataRepositoryImpl {
    
    private let apiManager : ApiManager
    
    init (apiManager: ApiManager) {
        self.apiManager = apiManager
    }
}

//MARK: - GitHubDataRepositoryProtocol

extension GitHubDataRepositoryImpl : GithubDataRepositoryProtocol {
    func getGitHubData(title: String, language: String, completion: @escaping (Result<GitHubData, Error>) -> Void) {
        let request = GetGitHubDataRequest(title: title, language: language)
        apiManager.makeRequest(request: request, completion: completion)
    }
}



