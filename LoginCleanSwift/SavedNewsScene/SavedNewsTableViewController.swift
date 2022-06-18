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

protocol SavedNewsDisplayLogic {
    func removeArticleFromeSavedArray(at index: Int)
    func reloadSavedTableView()
}

class SavedNewsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var interactor: SavedNewsBusinessLogic?
    weak var savedCoordinator: SavedNewsTableVCCoordinatorDelegate?
    
    var savedArticles = [ArticleModelProtocol]() {
        didSet {
            savedArticles.sort { $0.dateOfSave! > $1.dateOfSave! }
            reloadSavedTableView()
        }
    }
    
    var isDeleteModeActive = false
    
    lazy var savedModel = SavedNewsModel(savedArticles: savedArticles)

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved news"
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        setUpViews()
    }
    
    // MARK: - Actions
    @objc func navigateToProfileVC() {
        savedCoordinator?.navigateBackToProfileCoordinator()
    }
    
    @objc func deleteNewsButtonTapped() {
        isDeleteModeActive.toggle()
        setUpViews()
        reloadSavedTableView()
    }
    
    // MARK: - Methods
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    func setUpViews() {
        interactor?.setUpViews(isDeleteModeActive)
    }
    
    // MARK: - TableView Delegate & DataSource
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedModel.numberOfArticles(in: section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return savedModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell,
              let savedArticlesForSection = savedModel.articlesForSection(indexPath.section) else { return UITableViewCell() }
        cell.configureCell(with: savedArticlesForSection[indexPath.row], isDeleteModeActive)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isDeleteModeActive {
            
        } else {
            savedCoordinator?.showWebPage(savedModel.savedArticle(for: indexPath).urlToNewsSource)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = savedModel.sectionTitle(for: section)
        return sectionTitle
    }
    
    
}

// MARK: - SavedNewsDisplayLogic Delegate
extension SavedNewsTableViewController: SavedNewsDisplayLogic {
    func reloadSavedTableView() {
        tableView.reloadData()
    }
    
    func removeArticleFromeSavedArray(at index: Int) {
        savedArticles.remove(at: index)
        reloadSavedTableView()
    }
}

// MARK: - SavedNewsDisplayLogic Delegate
extension SavedNewsTableViewController: SavedNewsContainesDeleteButton {
    func deleteButtonTapped(_ cell: UITableViewCell) {
        guard let cellIndex = tableView.indexPath(for: cell) else { return }
        print("DEBUG::: IndexTapped \(cellIndex)")
        //interactor?.removeArticle(savedArticles[cellIndex.row], at: cellIndex.row)
    }
}
