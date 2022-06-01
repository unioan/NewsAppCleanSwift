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
}

protocol ProfileVCCoordinatorDelegate: AnyObject {
    func logout()
    func showWebPage(_ urlString: String)
    func showSavedNews()
}

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var profileView: ProfileView?
    var interactor: ProfileBusinessLogic?
    weak var profileCoordinator: ProfileVCCoordinatorDelegate?
    
    var userModel: UserModel? {
        didSet { profileView?.onUserModelInput(userModel, self) }
    }
    
    var articleModel: [ProfileModel.ArticleModel] = [] {
        didSet { profileView?.reloadTableView() }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBarButtons()
        setupDependencies()
        
        profileView?.onUserModelInput(userModel, self)
        interactor?.fetchTopNews()
    }
    
    // MARK: - Actions
    @objc func backButtonTapped() {
        profileCoordinator?.logout()
    }
    
    @objc func savedButtonTapped() {
        profileCoordinator?.showSavedNews()
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
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.configureCell(with: articleModel[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if articleModel.count > 5 && indexPath.row == articleModel.count - 1 {
            profileView?.isSpinnerShown = true
            interactor?.fetchTopNews()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileCoordinator?.showWebPage(articleModel[indexPath.row].urlToNewsSource)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let articleIsSaved = articleModel[indexPath.row].isSaved
        
        let tralingSwipeButton = UIContextualAction.createTrailingSwipeButton(articleIsSaved) {
            self.articleModel[indexPath.row].isSaved.toggle()
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [tralingSwipeButton])
        return swipeConfiguration
    }
    
}
// MARK: - ProfileDisplayLogic
extension ProfileViewController: ProfileDisplayLogic {
    func displayArticles(_ article: ProfileModel.ArticleDataTransfer.ViewModel) {
        articleModel.append(article.articleModel)
        self.profileView?.isSpinnerShown = false
    }
    func noMoreNewsLeft() {
        print("DEBUG fetchTopNews ERROR case in ProfileViewController")
        self.profileView?.isSpinnerShown = false
    }
}
