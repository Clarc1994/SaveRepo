//
//  DetailsRepositoryViewModel.swift
//  SaveRepo
//
//  Created by A1398 on 09/03/2023.
//

import Foundation

protocol DetailsRepositoryViewModelDelegate: AnyObject {
    func succesSaveData()
    func errorSaveItem(error: Error)
}

final class DetailsRepositoryViewModel {
    
    var item: Items?
    var dataBase: DataBase
    weak var delegate: DetailsRepositoryViewModelDelegate?

    init(item: Items?, db: DataBase, delegate: DetailsRepositoryViewModelDelegate?) {
        self.item = item
        self.dataBase = db
        self.delegate = delegate
    }
    
    func saveRepository(item: Items) {
        dataBase.itemDataBaseRepository.create(item: item) {result in
            switch result {
            case .success:
                self.delegate?.succesSaveData()
            case .failure(let error):
                self.delegate?.errorSaveItem(error: error)
            }
        }
    }
}
