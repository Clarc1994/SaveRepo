//
//  GettingAllItemsQuery.swift
//  SaveRepo
//
//  Created by A1398 on 06/04/2023.
//

import Foundation

struct GettingAllItemsQuery : QueryTypeProtocol {
    var predicate: NSPredicate? {
        return nil
    }
    
    var sortDescriptors: [NSSortDescriptor]? {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
}
