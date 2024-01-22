//
//  MainCoordinator.swift
//  SaveRepo
//
//  Created by A1398 on 28/11/2022.
//

import Foundation
import UIKit


final class MainCoordinator: CoordinatorProtocol {

    var navigationContoller: UINavigationController
    var apiManager: ApiManager
    var dataBase: DataBase
    
    init(nv : UINavigationController, apiManager: ApiManager, db: DataBase) {
        self.navigationContoller = nv
        self.apiManager = apiManager
        self.dataBase = db
    }
    
    func popNavigateController() {
        self.navigationContoller.popViewController(animated: true)
    }
    
    func configureRootViewController() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.mainCoordinator = self
        self.navigationContoller.pushViewController(welcomeVC, animated: false)
    }
    
    func navigateToSearchController() {
        let searchVC = SearchViewController(apiManager: apiManager)
        searchVC.mainCoordinator = self
        self.navigationContoller.pushViewController(searchVC, animated: true)
    }
    
    func navigateToListOfRepositoryViewController(data: GitHubData?) {
        let listOfRepositoryVC = ListOfRepositoryViewController(data: data)
        listOfRepositoryVC.mainCoordinator = self
        self.navigationContoller.pushViewController(listOfRepositoryVC, animated: true)
    }
    
    func navigateToDetailsRepositoryViewController(data: Items?) {
        let detailsRepositoryVC = DetailsRepositoryViewController(data: data, db: dataBase)
        detailsRepositoryVC.mainCoordinator = self
        self.navigationContoller.pushViewController(detailsRepositoryVC, animated: true)
    }
    
    func navigateToListOfSaveRepositoryViewController() {
        let listOfSaveRepositoryVC =  ListOfSaveRepositoryViewController(db: dataBase)
        listOfSaveRepositoryVC.mainCoordinator = self
        self.navigationContoller.pushViewController(listOfSaveRepositoryVC, animated: true)
    }
    
    func navigateToDetailsSaveRepositoryViewController(data: ItemDataBase?) {
        let detailsSaveRepositoryVC = DetailSaveRepositoryViewController(db: dataBase, data: data)
        detailsSaveRepositoryVC.mainCoordinator = self
        self.navigationContoller.pushViewController(detailsSaveRepositoryVC, animated: true)
    }
}
