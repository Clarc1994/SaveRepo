//
//  ItemDataBaseRepositoryImpl.swift
//  SaveRepo
//
//  Created by A1398 on 03/04/2023.
//

import Foundation
import CoreData

enum VoidResult<E: Error> {
    case success
    case failure(E)
}


protocol ItemDataBaseRepositoryProtocol {
    func create(item: Items, completion: @escaping((VoidResult<Error>) -> Void))
    func getItemsDataBase(query: QueryTypeProtocol, completion: @escaping ((Result<[ItemDataBase],Error>) -> Void))
    func deleteItemDataBase(item: ItemDataBase, completion: @escaping ((VoidResult<Error>) -> Void))
}

final class ItemDataBaseRepositoryImpl {
    private let repository: DataBaseManager<ItemDataBaseMO>
    
    init(context: NSManagedObjectContext) {
        self.repository = DataBaseManager<ItemDataBaseMO>(managedObjectContext: context)
    }
}

// MARK:- Implements method ItemDataBaseProtocol

extension ItemDataBaseRepositoryImpl : ItemDataBaseRepositoryProtocol {
    
    
    
    func create(item: Items, completion: @escaping ((VoidResult<Error>) -> Void)) {
        do {
            let itemMO = try repository.create()
            itemMO.html_url = item.html_url
            itemMO.id = Int32(item.id)
            itemMO.language = item.language
            itemMO.login = item.owner.login
            itemMO.name = item.name
            itemMO.stargazers_count = Int32(item.stargazers_count)
            try repository.saveChanges()
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getItemsDataBase(query: QueryTypeProtocol, completion: @escaping ((Result<[ItemDataBase], Error>) -> Void)) {
        
        do {
            let itemMO = try repository.get(predicate: query.predicate, sortDescriptors: query.sortDescriptors)
            let item = itemMO.map { itemMO -> ItemDataBase in return itemMO.toDomainModel() }
            completion(.success(item))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    func deleteItemDataBase(item: ItemDataBase, completion: @escaping ((VoidResult<Error>) -> Void)){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.DataBaseNameClass.nameItemDataBaseMO)
        fetchRequest.predicate = NSPredicate(format: "name = %@", item.name!)
        do {
            let result = try repository.get(predicate: fetchRequest.predicate, sortDescriptors: nil)
            let objectToDelete = result[0]
            try repository.delete(entity: objectToDelete)
            completion (.success)
        }catch {
            completion(.failure(error))
        }
    }
    
    
    
}


