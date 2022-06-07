//
//  ProfileViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import UIKit

protocol ProfileDisplayLogic {
    var profileView: ProfileView? { get set }
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
    
    var selectedCategory: SearchArticlesCategoryType = .general {
        didSet {
            articleModels.removeAll()
            interactor?.fetchTopNews(selectedCategory: selectedCategory)
            profileView?.reloadCollectionView()
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
        interactor?.setUpNavigationBarButtons()
        
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
            interactor?.fetchTopNews(selectedCategory: selectedCategory)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileCoordinator?.showWebPage(articleModels[indexPath.row].urlToNewsSource)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var articleTapped = articleModels[indexPath.row]

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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        interactor?.animateNewsTableViewHeader(scrollView.bounds.origin.y)
    }
    
}
// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SearchCategoryHeaderType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionKind = SearchCategoryHeaderType(rawValue: section) else { fatalError() }
        switch sectionKind {
        case .searchCategory:
            return SearchArticlesCategoryType.allCases.count
        case .searchBar:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionKind = SearchCategoryHeaderType(rawValue: indexPath.section) else { fatalError() }
        switch sectionKind {
        case .searchCategory:
            guard let categoryType = SearchArticlesCategoryType.init(rawValue: indexPath.item),
                  let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchArticlesCategoryCell.identifier, for: indexPath) as? SearchArticlesCategoryCell else { fatalError() }
            categoryType == selectedCategory ? categoryCell.selectedAppearence(true) : categoryCell.selectedAppearence(false)
            categoryCell.configureCell(categoryType.cellText)
            return categoryCell
        case .searchBar:
            guard let searchBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCategoryBarCell.identifier, for: indexPath) as? SearchCategoryBarCell else { fatalError() }
            searchBarCell.searchBar.delegate = self
            if selectedCategory == .general {
                searchBarCell.searchBar.searchTextField.isEnabled = false
                searchBarCell.searchBar.searchTextField.text = ""
            } else {
                searchBarCell.searchBar.searchTextField.isEnabled = true
            }
            return searchBarCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let selectedCategory = SearchArticlesCategoryType(rawValue: indexPath.item) else { return }
            self.selectedCategory = selectedCategory
//            if selectedCategory == .general {
//                interactor?.fetchTopNews()
//            }
        }
    }
    
}

extension ProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text != " ", selectedCategory != .general else { return }
        print("DEBUG:: text \(searchBar.text?.lowercased()) has been entered")
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
