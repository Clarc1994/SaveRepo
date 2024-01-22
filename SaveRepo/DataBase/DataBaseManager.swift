//
//  DataBaseManager.swift
//  SaveRepo
//
//  Created by A1398 on 27/03/2023.
//

import Foundation

import UIKit
import CoreData

enum DataBaseManagerError: Error {
    case invalidManagedObjectType
    case saveContextError
    case getDataError
}

protocol DataBaseProtocol {
    associatedtype Entity
    func create() throws -> Entity
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) throws -> [Entity]
}

final class DataBaseManager<T: NSManagedObject>: DataBaseProtocol {

    typealias Entity = T
    private let managedObjectContext : NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func create() throws -> Entity {
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else {
            throw DataBaseManagerError.invalidManagedObjectType
        }
        return managedObject
    }
    
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) throws -> [T] {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                return fetchResults
            } else {
                throw DataBaseManagerError.invalidManagedObjectType
            }
        } catch {
            throw DataBaseManagerError.getDataError
        }
    }
    
    func delete(entity:Entity) throws ->Void {
        managedObjectContext.delete(entity)
        do {
            try saveChanges()
        } catch {
            throw DataBaseManagerError.saveContextError
        }
    }
    
    func saveChanges() throws -> Void {
        do {
            try managedObjectContext.save()
        } catch {
            managedObjectContext.rollback()
            throw DataBaseManagerError.saveContextError
        }
    }
}
