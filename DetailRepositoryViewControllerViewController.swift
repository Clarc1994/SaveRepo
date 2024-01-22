//
//  DetailRepositoryViewControllerViewController.swift
//  SaveRepo
//
//  Created by A1398 on 07/03/2023.
//

import UIKit

protocol DetailsRepositoryView: AnyObject {}

final class DetailRepositoryViewControllerViewController: UIViewController {
    
    // MARK: Pola prywatne
    private var contentView: DetailsRepositoryContentView { return view as! DetailsRepositoryContentView }
    private var presenter: DetailsRepositoryPresenter!

    // MARK: Inicjalizacja
    convenience init(delegate: DetailsRepositoryPresenterDelegate, kontenerZaleznosci: DetailsRepositoryPresenter.KontenerZaleznosci) {
        self.init(nibName: nil, bundle: nil)
        self.presenter = DetailsRepositoryPresenterImpl(
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
// MARK: - DetailsRepositoryView
extension DetailRepositoryViewControllerViewController: DetailsRepositoryView {}
