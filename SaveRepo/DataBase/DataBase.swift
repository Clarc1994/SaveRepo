//
//  DataBase.swift
//  SaveRepo
//
//  Created by A1398 on 04/04/2023.
//

import Foundation
import CoreData
import UIKit

final class DataBase {
    private let context: NSManagedObjectContext
    let itemDataBaseRepository: ItemDataBaseRepositoryImpl
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        self.itemDataBaseRepository = ItemDataBaseRepositoryImpl(context: self.context)
    }
}
