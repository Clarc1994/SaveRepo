//
//  DetailsRepositoryViewController.swift
//  SaveRepo
//
//  Created by A1398 on 07/03/2023.
//

import UIKit


final class DetailsRepositoryViewController: UIViewController {
    
    @IBOutlet private(set) weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var authorLabel: UILabel!
    @IBOutlet private(set) weak var languageLabel: UILabel!
    @IBOutlet private(set) weak var starsLabel: UILabel!
    @IBOutlet private(set) weak var viewSuccessSave: UIView!
    @IBOutlet private(set) weak var viewStar: UIView!
    @IBOutlet private(set) weak var openInSafariButton: UIButton!
    @IBOutlet private(set) weak var saveButton: UIButton!
    @IBOutlet private(set) weak var prevButton: UIButton!
    
    private var viewModel : DetailsRepositoryViewModel!
    weak var mainCoordinator: MainCoordinator?
    
    // MARK: Cykl życia widoku
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.setCornerRadius()
        authorLabel.setCornerRadius()
        languageLabel.setCornerRadius()
        openInSafariButton.layer.cornerRadius = 20
        saveButton.layer.cornerRadius = 20
        prevButton.layer.cornerRadius = 20
        viewSuccessSave.isHidden = true
        viewSuccessSave.layer.cornerRadius = viewSuccessSave.frame.height / 2
        viewSuccessSave.layer.borderWidth = 1
        viewSuccessSave.layer.backgroundColor = UIColor.white.cgColor
        viewStar.layer.cornerRadius = viewStar.layer.frame.height / 2
        nameLabel.text = "\t\(viewModel.item?.name ?? "brak")"
        languageLabel.text = "\t\(viewModel.item?.language ?? "brak")"
        authorLabel.text = "\t\(viewModel.item?.owner.login ?? "brak")"
        if let stars = viewModel.item?.stargazers_count {
            starsLabel.text = String(stars)
        } else {
            starsLabel.text = "brak"
        }
    }
    
    convenience init(data: Items?, db: DataBase) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = DetailsRepositoryViewModel(item: data, db: db, delegate: self)
      
    }
    
    @IBAction func pressOpenInSafari(_ sender: Any) {
        guard let url = URL(string: (viewModel.item?.html_url)!) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func pressSaveButton(_ sender: Any) {
        viewModel.saveRepository(item: viewModel.item!)
    }
    
    @IBAction func pressPrevButton(_ sender: Any) {
        mainCoordinator?.popNavigateController()
    }
    
    private func runErrorAlert() {
        let alert = UIAlertController(title: K.TextAlert.dataSaveError, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            return
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Details Repository View Model Delegate Method

extension DetailsRepositoryViewController : DetailsRepositoryViewModelDelegate {
    func succesSaveData() {
        DispatchQueue.main.async { [self] in
            viewSuccessSave.isHidden = false
        }
    }
    
    func errorSaveItem(error: Error) {
        DispatchQueue.main.async { [self] in
            runErrorAlert()
        }
    }
}
