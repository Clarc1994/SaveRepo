//
//  ListOfRepositoryViewController.swift
//  SaveRepo
//
//  Created by A1398 on 20/02/2023.
//

import UIKit

final class ListOfRepositoryViewController: UIViewController, UITableViewDelegate {
    
    private var viewModel : ListOfRepositoryViewModel!
    weak var mainCoordinator : MainCoordinator?
    
    @IBOutlet private(set) weak var emptyImageView: UIImageView!
    @IBOutlet private(set) weak var prevButton: UIButton!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    // MARK: Cykl życia widoku
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    convenience init(data: GitHubData?) {
        self.init(nibName: nil, bundle: nil)
        viewModel = ListOfRepositoryViewModel()
        viewModel.downloadData = data
        guard let countResult = data?.items.count else { return }
        viewModel.statusData = [Bool](repeating: false, count: countResult)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.layer.cornerRadius = 20
        tableView.backgroundColor = UIColor.systemTeal
        tableView.register(UINib(nibName: K.Cell.CellRepozytoryNibName, bundle: nil), forCellReuseIdentifier: K.Cell.CellRepozytoryIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        tableView.reloadData()
        if viewModel.downloadData?.items.count == 0 {
            isEmptyResults(empty: true)
        } else {
            isEmptyResults(empty: false)
        }
    }
    
    @IBAction func pressPrevButton(_ sender: Any) {
        mainCoordinator?.popNavigateController()
    }
    
    func isEmptyResults(empty: Bool) {
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

extension ListOfRepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.downloadData?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = viewModel.downloadData?.items[indexPath.row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.CellRepozytoryIdentifier, for: indexPath) as! CellListOfRepository
            cell.nameProjectLabel.text = item.name
            cell.starLabel.text = String(item.stargazers_count)
            if viewModel.statusData?[indexPath.row] == false {
                cell.statusLabel.isHidden = true
            } else {
                cell.statusLabel.isHidden = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.CellRepozytoryIdentifier, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.statusData?[indexPath.row] = true
        mainCoordinator?.navigateToDetailsRepositoryViewController(data: viewModel.downloadData?.items[indexPath.row])
    }
}
