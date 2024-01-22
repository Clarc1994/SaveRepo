//
//  ItemDataBaseMO.swift
//  SaveRepo
//
//  Created by A1398 on 27/03/2023.
//

import Foundation
import CoreData

protocol DomainModelProtocol {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}

extension ItemDataBaseMO: DomainModelProtocol {
    func toDomainModel() -> ItemDataBase {
        return ItemDataBase(id: Int(id),
                            name: name,
                            html_url: html_url,
                            stargazers_count: Int(stargazers_count),
                            language: language,
                            login: login)
    }
}
