//
//  DetailsSaveRepositoryViewModel.swift
//  SaveRepo
//
//  Created by A1398 on 09/06/2023.
//

import Foundation

protocol DetailsSaveRepositoryViewModelDelegate: AnyObject {
    func succesDeleteRecord()
    func errorDeleteRecord(error: Error)
}

final class DetailsSaveRepositoryViewModel {
    
    private let dataBase: DataBase
    private weak var delegate: DetailsSaveRepositoryViewModelDelegate?
    var data: ItemDataBase?
    
    init(dataBase:DataBase, data: ItemDataBase?, delegate: DetailsSaveRepositoryViewModelDelegate?) {
        self.dataBase = dataBase
        self.delegate = delegate
        self.data = data
    }
    
    func deleteRecord(item: ItemDataBase) {
        dataBase.itemDataBaseRepository.deleteItemDataBase(item: item) { result in
            switch result {
            case .success:
                self.delegate?.succesDeleteRecord()
            case .failure(let error):
                self.delegate?.errorDeleteRecord(error: error)
            }
        }
    }
}
