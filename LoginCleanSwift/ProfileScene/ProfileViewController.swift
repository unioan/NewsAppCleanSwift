//
//  ProfileViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import UIKit

protocol ProfileDisplayLogic {
    func displayArticles(_ article: ProfileModel.ArticleDataTransfer.ViewModel)
    func noMoreNewsLeft()
    func getSavedArticles()
    func removeArticleFromeSavedArray(_ index: Int)
}

protocol ProfileVCCoordinatorDelegate: AnyObject {
    func logout()
    func showWebPage(_ urlString: String)
    func showSavedNews(_ savedArticles: [ArticleModelProtocol])
}

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var profileView: ProfileView?
    var interactor: ProfileBusinessLogic?
    weak var profileCoordinator: ProfileVCCoordinatorDelegate?
    
    var userModel: UserModel? {
        didSet { profileView?.onUserModelInput(userModel, self) }
    }
    
    var articleModels: [ArticleModelProtocol] = [] {
        didSet {
            savedArticles.markAsSaved(in: &articleModels)
            profileView?.reloadTableView()
        }
    }
    
    var savedArticles: [ArticleModelProtocol] = [] {
        didSet { savedArticles.markAsSaved(in: &articleModels) }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBarButtons()
        setupDependencies()
        
        profileView?.onUserModelInput(userModel, self)
        interactor?.fetchTopNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSavedArticles()
    }
    
    // MARK: - Actions
    @objc func backButtonTapped() {
        profileCoordinator?.logout()
        NewsService.resetNewsService()
    }
    
    @objc func savedButtonTapped() {
        profileCoordinator?.showSavedNews(savedArticles)
    }
    
    // MARK: - Methods
    func setUpNavigationBarButtons() {
        let leftButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(title: "Saved", style: .plain, target: self, action: #selector(savedButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupDependencies() {
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        
        self.interactor = interactor
        interactor.presentor = presenter
        presenter.viewController = self
        
        profileView = ProfileView()
        view = profileView
    }
    
    func getSavedArticles() {
        NewsPersistanceManager.shared.getSavedArticles { savedArticles in
            self.savedArticles = savedArticles
        }
    }
    
    func removeArticleFromeSavedArray(_ index: Int) {
        markArticleAsNotSaved(index)
        savedArticles.remove(at: index)
    }
    
    func markArticleAsNotSaved(_ index: Int) {
        let savedArticle = savedArticles[index]
        let indexInArticleModels = articleModels.firstIndex { $0.title == savedArticle.title }
        if let indexInArticleModels = indexInArticleModels {
            articleModels[indexInArticleModels].isSaved = false
        }
    }
    
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.configureCell(with: articleModels[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if articleModels.count > 5 && indexPath.row == articleModels.count - 1 {
            profileView?.isSpinnerShown = true
            interactor?.fetchTopNews()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileCoordinator?.showWebPage(articleModels[indexPath.row].urlToNewsSource)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var articleTapped = articleModels[indexPath.row]
//        let savedArticle = savedArticles.first { $0.title == articleModels[indexPath.row].title }
//        if let _ = savedArticle { articleTapped.isSaved = true }

        let tralingSwipeButton = UIContextualAction.createTrailingSwipeButton(articleTapped) { actionType in
            switch actionType {
            case .save:
                articleTapped.dateOfSave = Date()
                self.interactor?.saveArticle(articleTapped)
            case .delete:
                self.interactor?.removeArticle(articleTapped, from: self.savedArticles)
            }
        }

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [tralingSwipeButton])
        return swipeConfiguration
    }
    
}
// MARK: - ProfileDisplayLogic
extension ProfileViewController: ProfileDisplayLogic {
    func displayArticles(_ article: ProfileModel.ArticleDataTransfer.ViewModel) {
        articleModels.append(article.articleModel)
        self.profileView?.isSpinnerShown = true
    }
    func noMoreNewsLeft() {
        self.profileView?.isSpinnerShown = false
    }
}
