//
//  SearchViewController.swift
//  SaveRepo
//
//  Created by A1398 on 10/01/2023.
//

import UIKit


final class SearchViewController: UIViewController {
    
    weak var mainCoordinator : MainCoordinator?
    private var searchViewModel : SearchViewModel!
    
    @IBOutlet private(set) weak var languageTextField: UITextField!
    @IBOutlet private(set) weak var textTextField: UITextField!
    @IBOutlet private(set) weak var prevButton: UIButton!
    @IBOutlet private(set) weak var searchButton: UIButton!
    @IBOutlet private(set) weak var loadingActivityInd: UIActivityIndicatorView!
    
    convenience init (apiManager: ApiManager) {
        self.init(nibName: nil, bundle: nil)
        searchViewModel = SearchViewModel(gitHubRepository: GitHubDataRepositoryImpl(apiManager: apiManager), delegate: self)
    }
    
    // MARK: Cykl życia widoku
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.layer.cornerRadius = 20
        searchButton.layer.cornerRadius = 20
        loadingActivityInd.isHidden = true
        textTextField.layer.cornerRadius = 15
        textTextField.layer.borderWidth = 2
        textTextField.layer.borderColor = UIColor.white.cgColor
        textTextField.layer.masksToBounds = true
        languageTextField.layer.cornerRadius = 15
        languageTextField.layer.borderWidth = 2
        languageTextField.layer.borderColor = UIColor.white.cgColor
        languageTextField.layer.masksToBounds = true
        textTextField.delegate = self
        languageTextField.delegate = self
    }
    
    @IBAction private func pressSearchButton(_ sender: Any) {
        textTextField.endEditing(true)
        if textTextField.text != "", languageTextField.text != "" {
            loadingActivityInd.isHidden = false
            loadingActivityInd.startAnimating()
            searchViewModel.getGitHubData(title: textTextField.text!, language: languageTextField.text!)
        } else {
            runAlert()
        }
    }
    
    @IBAction private func pressPrevButton(_ sender: Any) {
        mainCoordinator?.popNavigateController()
    }
    
    private func runAlert() {
        let alert = UIAlertController(title: "Uzupełnij wszystkie pola", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            return
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func errorAlert() {
        let alert = UIAlertController(title: "Błąd pobierania danych", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            return
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - textFieldDelegate Method
extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func getGitHubData(data: GitHubData) {
        DispatchQueue.main.async { [self] in
            loadingActivityInd.stopAnimating()
            loadingActivityInd.isHidden = true
            mainCoordinator?.navigateToListOfRepositoryViewController(data: data)
        }
    }
    
    func errorGitHubData(error: Error) {
        DispatchQueue.main.async { [self] in
            loadingActivityInd.stopAnimating()
            loadingActivityInd.isHidden = true
            errorAlert()
        }
    }
}
