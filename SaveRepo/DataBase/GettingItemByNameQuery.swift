//
//  GettingItemByNameQuery.swift
//  SaveRepo
//
//  Created by A1398 on 06/06/2023.
//

import Foundation

struct GettingItemByNameQuery: QueryTypeProtocol {
    var itemName: String?
    
    var predicate: NSPredicate? {
        guard let name = itemName, itemName != "" else { return nil }
        return NSPredicate(format: "name Contains[cd]%@", name)
    }
    
    var sortDescriptors: [NSSortDescriptor]? {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}
