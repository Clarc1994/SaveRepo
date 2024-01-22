//
//  WelcomeViewController.swift
//  SaveRepo
//
//  Created by A1398 on 28/11/2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    @IBOutlet private(set) weak var searchRepoButton: UIButton!
    @IBOutlet private(set) weak var saveRepoButton: UIButton!
    
    weak var mainCoordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCoordinator?.navigationContoller.isNavigationBarHidden = true
        searchRepoButton.layer.cornerRadius = 20
        saveRepoButton.layer.cornerRadius = 20
    }
    
    @IBAction private func  pressSaveRepository(_ sender: Any) {
        mainCoordinator?.navigateToListOfSaveRepositoryViewController()
    }
    
    @IBAction private func  pressSearch(_ sender: Any) {
        mainCoordinator?.navigateToSearchController()
    }
    
    // MARK: Cykl życia widoku
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
