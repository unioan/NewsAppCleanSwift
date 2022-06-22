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
    func removeArticleFromSavedAdapter(_ article: ArticleModelProtocol, at indexPath: IndexPath)
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
    
    lazy var savedNews = SavedNewsAdapter(savedArticles: savedArticles)
    
    
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
        return savedNews.numberOfArticles(in: section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return savedNews.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell,
              let savedArticlesForSection = savedNews.articlesForSection(indexPath.section) else { return UITableViewCell() }
        cell.configureCell(with: savedArticlesForSection[indexPath.row], isDeleteModeActive)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isDeleteModeActive {
            let tappedArticle = savedNews.getSavedArticle(for: indexPath)
            savedCoordinator?.showWebPage(tappedArticle.urlToNewsSource)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = savedNews.sectionTitle(for: section)
        return sectionTitle
    }
    
}

// MARK: - SavedNewsDisplayLogic Delegate
extension SavedNewsTableViewController: SavedNewsDisplayLogic {
    func reloadSavedTableView() {
        tableView.reloadData()
    }
    
    func removeArticleFromSavedAdapter(_ article: ArticleModelProtocol, at indexPath: IndexPath)  {
        savedNews.deleteFromSavedNews(article, at: indexPath)
        reloadSavedTableView()
    }
}

// MARK: - SavedNewsDisplayLogic Delegate
extension SavedNewsTableViewController: SavedNewsContainesDeleteButton {
    func deleteButtonTapped(_ cell: UITableViewCell) {
        guard let cellIndexPath = tableView.indexPath(for: cell) else { return }
        let savedArticleFromIndexPath = savedNews.getSavedArticle(for: cellIndexPath)
        interactor?.removeArticle(savedArticleFromIndexPath, at: cellIndexPath)
    }
}
