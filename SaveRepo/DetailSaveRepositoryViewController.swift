//
//  DetailSaveRepositoryViewController.swift
//  SaveRepo
//
//  Created by A1398 on 06/06/2023.
//

import UIKit

final class DetailSaveRepositoryViewController: UIViewController {
    
    @IBOutlet private(set) weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var authorLabel: UILabel!
    @IBOutlet private(set) weak var languageLabel: UILabel!
    @IBOutlet private(set) weak var starsLabel: UILabel!
    @IBOutlet private(set) weak var prevButton: UIButton!
    @IBOutlet private(set) weak var openInSafariButton: UIButton!
    @IBOutlet private(set) weak var deleteButton: UIButton!
    @IBOutlet private(set) weak var starsView: UIView!
    
    private var viewModel: DetailsSaveRepositoryViewModel!
    weak var mainCoordinator: MainCoordinator?
    
    convenience init(db:DataBase, data: ItemDataBase?) {
        self.init(nibName: nil, bundle: nil)
        viewModel = DetailsSaveRepositoryViewModel(dataBase: db, data: data, delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        openInSafariButton.layer.cornerRadius = 20
        deleteButton.layer.cornerRadius = 20
        prevButton.layer.cornerRadius = 20
        nameLabel.text = "\t\(viewModel.data?.name ?? "brak")"
        authorLabel.text = "\t\(viewModel.data?.login ?? "brak")"
        languageLabel.text = "\t\(viewModel.data?.language ?? "brak")"
        if let stars = viewModel.data?.stargazers_count {
            starsLabel.text = String(stars)
        } else {
            starsLabel.text = "brak"
        }
        nameLabel.setCornerRadius()
        authorLabel.setCornerRadius()
        languageLabel.setCornerRadius()
        starsView.layer.cornerRadius = starsView.layer.frame.height / 2
    }
    
    @IBAction func pressOpenInSafari(_ sender: Any) {
        guard let url = URL(string: (viewModel.data?.html_url)!) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func pressDelete(_ sender: Any) {
        guard let data = viewModel.data else {return}
        viewModel.deleteRecord(item: data)
    }
    
    @IBAction func pressPrev(_ sender: Any) {
        mainCoordinator?.popNavigateController()
    }
    
    private func runErrorAlert() {
        let alert = UIAlertController(title: K.TextAlert.dataDeleteError, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            return
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func succesDeleteAlert() {
        let alert = UIAlertController(title: K.TextAlert.deleteSucces, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.mainCoordinator?.popNavigateController()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension DetailSaveRepositoryViewController: DetailsSaveRepositoryViewModelDelegate {
    func succesDeleteRecord() {
        DispatchQueue.main.async { [self] in
            succesDeleteAlert()
        }
    }
    
    func errorDeleteRecord(error: Error) {
        DispatchQueue.main.async { [self] in
            runErrorAlert()
        }
    }
}
