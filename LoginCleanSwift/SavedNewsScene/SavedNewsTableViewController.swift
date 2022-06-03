//
//  SavedNewsTableViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 26.05.2022.
//

import UIKit

protocol SavedNewsTableVCCoordinatorDelegate: AnyObject {
    func navigateBackToProfileCoordinator()
    func showWebPage(_ urlString: String)
}

class SavedNewsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var savedArticles = [ArticleModelProtocol]()
    weak var savedCoordinator: SavedNewsTableVCCoordinatorDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved news"
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        setUpBackBarButton()
    }
    
    // MARK: - Actions
    @objc func navigateToProfileVC() {
        print("DEBUG: SavedNewsTableViewController / navigateToProfileVC method")
        savedCoordinator?.navigateBackToProfileCoordinator()
    }
    
    // MARK: - Methods
    func setUpBackBarButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateToProfileVC))
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - TableView Delegate & DataSource
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { return UITableViewCell() }
        cell.configureCell(with: savedArticles[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        savedCoordinator?.showWebPage(savedArticles[indexPath.row].urlToNewsSource)
    }
    
}
