//
//  QueryTypeProtocol.swift
//  SaveRepo
//
//  Created by A1398 on 06/04/2023.
//

import Foundation

protocol QueryTypeProtocol {
    var predicate: NSPredicate? { get }
    var sortDescriptors : [NSSortDescriptor]? { get }
}
