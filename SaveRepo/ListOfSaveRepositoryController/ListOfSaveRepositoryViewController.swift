//
//  ListOfSaveRepositoryViewController.swift
//  SaveRepo
//
//  Created by A1398 on 05/04/2023.
//

import UIKit

final class ListOfSaveRepositoryViewController: UIViewController, UITableViewDelegate {

    @IBOutlet private(set) weak var searchBar: UISearchBar!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var prevButton: UIButton!
    @IBOutlet private(set) weak var emptyImageView: UIImageView!
    @IBOutlet private(set) weak var emptyLabel: UILabel!
    
    private var viewModel: ListOfSaveRepositoryViewModel!
    weak var mainCoordinator: MainCoordinator?
    
    convenience init(db: DataBase) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = ListOfSaveRepositoryViewModel(db: db, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.layer.cornerRadius = 20
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.Cell.CellRepozytoryNibName, bundle: nil), forCellReuseIdentifier: K.Cell.CellRepozytoryIdentifier)
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAllSaveRepository()
    }
    
    @IBAction func pressPrevButton(_ sender: Any) {
        mainCoordinator?.popNavigateController()
    }
    
    private func runErrorAlert() {
        let alert = UIAlertController(title: K.TextAlert.dataHandlingError, message: "" , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.mainCoordinator?.popNavigateController()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func isEmptyResult(empty: Bool) {
        if empty {
            emptyImageView.isHidden = false
            emptyLabel.isHidden = false
            tableView.isHidden = true
        } else {
            emptyImageView.isHidden = true
            emptyLabel.isHidden = true
            tableView.isHidden = false
        }
    }
}

extension ListOfSaveRepositoryViewController: ListOfSaveRepositoryViewModelDelegate {
    func getRecordError() {
        DispatchQueue.main.async { [self] in
            runErrorAlert()
        }
    }
    
    func receivedNewData() {
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
            if viewModel.dataDownload?.count ?? 0 == 0 {
                isEmptyResult(empty: true)
            } else {
                isEmptyResult(empty: false)
            }
        }
    }
    
    
}

extension ListOfSaveRepositoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.getRecords(text: text)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        if text.count == 0 {
            viewModel.getAllSaveRepository()
        } else {
            viewModel.getRecords(text: text)
        }
    }
}

extension ListOfSaveRepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataDownload?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = viewModel.dataDownload?[indexPath.row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.CellRepozytoryIdentifier, for: indexPath) as! CellListOfRepository
            cell.nameProjectLabel.text = item.name
            cell.starLabel.text = String(item.stargazers_count)
            cell.statusLabel.isHidden = true
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.CellSimpleIdentifier, for: indexPath)
            cell.textLabel?.text = "Brak wynikow"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainCoordinator?.navigateToDetailsSaveRepositoryViewController(data: viewModel.dataDownload?[indexPath.row])
    }
    
}
