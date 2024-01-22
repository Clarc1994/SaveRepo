//
//  SearchViewModel.swift
//  SaveRepo
//
//  Created by A1398 on 10/01/2023.
//

import Foundation


protocol SearchViewModelDelegate: AnyObject {
    func getGitHubData(data: GitHubData)
    func errorGitHubData(error: Error)
}

final class SearchViewModel {
    
    private let gitHubRepository: GitHubDataRepositoryImpl
    private weak var delegate: SearchViewModelDelegate?
    
    init(gitHubRepository: GitHubDataRepositoryImpl, delegate: SearchViewModelDelegate?) {
        self.gitHubRepository = gitHubRepository
        self.delegate = delegate
    }
    
    func getGitHubData(title: String, language: String) {
        gitHubRepository.getGitHubData(title: title, language: language) { (result: Result<GitHubData, Error>) in
            switch result {
            case .success(let gitHubData):
                self.delegate?.getGitHubData(data: gitHubData)
            case .failure(let error):
                self.delegate?.errorGitHubData(error: error)
            }
        }
    }
}
