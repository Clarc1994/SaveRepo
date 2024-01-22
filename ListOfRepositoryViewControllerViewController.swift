//
//  ListOfRepositoryViewControllerViewController.swift
//  SaveRepo
//
//  Created by A1398 on 20/02/2023.
//

import UIKit

protocol ListOfRepositoryViewControllerView: AnyObject {}

final class ListOfRepositoryViewControllerViewController: UIViewController {
    
    // MARK: Pola prywatne
    private var contentView: ListOfRepositoryViewControllerContentView { return view as! ListOfRepositoryViewControllerContentView }
    private var presenter: ListOfRepositoryViewControllerPresenter!

    // MARK: Inicjalizacja
    convenience init(delegate: ListOfRepositoryViewControllerPresenterDelegate, kontenerZaleznosci: ListOfRepositoryViewControllerPresenter.KontenerZaleznosci) {
        self.init(nibName: nil, bundle: nil)
        self.presenter = ListOfRepositoryViewControllerPresenterImpl(
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
// MARK: - ListOfRepositoryViewControllerView
extension ListOfRepositoryViewControllerViewController: ListOfRepositoryViewControllerView {}
