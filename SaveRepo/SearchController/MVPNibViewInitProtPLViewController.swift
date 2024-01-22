//
//  MVPNibViewInitProtPLViewController.swift
//  SaveRepo
//
//  Created by A1398 on 10/01/2023.
//

import UIKit

protocol SearchView: AnyObject {}

final class MVPNibViewInitProtPLViewController: UIViewController {
    
    // MARK: Pola prywatne
    private var contentView: SearchContentView { return view as! SearchContentView }
    private var presenter: SearchPresenter!

    // MARK: Inicjalizacja
    convenience init(delegate: SearchPresenterDelegate, kontenerZaleznosci: SearchPresenter.KontenerZaleznosci) {
        self.init(nibName: nil, bundle: nil)
        self.presenter = SearchPresenterImpl(
            view: self,
            delegate: delegate,
            kontenerZaleznosci: kontenerZaleznosci
        )
    }
    
    // MARK: Cykl życia widoku
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
// MARK: - SearchView
extension MVPNibViewInitProtPLViewController: SearchView {}
