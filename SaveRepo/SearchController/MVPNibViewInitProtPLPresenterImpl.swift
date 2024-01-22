//  
//  MVPNibViewInitProtPLPresenterImpl.swift
//  SaveRepo
//
//  Created by A1398 on 10/01/2023.
//

import Foundation

protocol SearchPresenterDelegate: AnyObject {}

protocol SearchPresenter {
    
    typealias KontenerZaleznosci = <#type expression#>
    
    init(view: SearchView, delegate: SearchPresenterDelegate, kontenerZaleznosci: KontenerZaleznosci)
    
}

final class SearchPresenterImpl: SearchPresenter {
    
    // MARK: Pola prywatne
    private weak var view: SearchView?
    private weak var delegate: SearchPresenterDelegate?
    private let kontenerZaleznosci: KontenerZaleznosci
    
    // MARK: Inicjalizacja
    required init(view: SearchView, delegate: SearchPresenterDelegate, kontenerZaleznosci: KontenerZaleznosci) {
        self.view = view
        self.delegate = delegate
        self.kontenerZaleznosci = kontenerZaleznosci
    }
    
}
