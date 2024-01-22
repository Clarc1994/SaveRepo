//
//  ListOfSaveRepositoryViewModel.swift
//  SaveRepo
//
//  Created by A1398 on 06/04/2023.
//

import Foundation

protocol ListOfSaveRepositoryViewModelDelegate : AnyObject {
    func getRecordError()
    func receivedNewData()
}

final class ListOfSaveRepositoryViewModel {
    
    private weak var delegate: ListOfSaveRepositoryViewModelDelegate?
    private let dataBase: DataBase
    var dataDownload: [ItemDataBase]?
    
    init(db:DataBase, delegate: ListOfSaveRepositoryViewModelDelegate?) {
        self.dataBase = db
        self.delegate = delegate
    }
    
    func getAllSaveRepository() {
        dataBase.itemDataBaseRepository.getItemsDataBase(query: GettingAllItemsQuery()) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let items):
                strongSelf.dataDownload = items
                strongSelf.delegate?.receivedNewData()
            case .failure(_):
                strongSelf.delegate?.getRecordError()
            }
        }
    }
    
    func getRecords(text:String){
        dataBase.itemDataBaseRepository.getItemsDataBase(query: GettingItemByNameQuery(itemName: text)) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let items):
                strongSelf.dataDownload = items
                strongSelf.delegate?.receivedNewData()
            case .failure(_):
                strongSelf.delegate?.getRecordError()
            }
        }
    }
}
