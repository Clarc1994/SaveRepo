//
//  Items.swift
//  SaveRepo
//
//  Created by A1398 on 10/01/2023.
//

import Foundation

struct Items: Codable {
    let id: Int
    let name: String
    let owner: Owner
    let html_url: String
    let stargazers_count: Int
    let language: String
}
