//
//  ProfileCoordinator.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 17.04.2022.
//

import UIKit

protocol BackToAuthorizstionCoordinateDelegate: AnyObject {
    func navigateToAuthorizationScene()
}

final class ProfileCoordinator: Coodrinator {
    
    var childCoordinators: [Coodrinator] = []
    weak var delegate: BackToAuthorizstionCoordinateDelegate?
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ userModel: UserModel) {
        let profileVC = ProfileViewController()
        profileVC.userModel = userModel 
        profileVC.profileCoordinator = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController.pushViewController(profileVC, animated: true)
        }
    }
    
}

// MARK: - SavedNewsViewController Delegate
extension ProfileCoordinator: ProfileVCCoordinatorDelegate {
    func showWebPage(_ urlString: String) {
        let webVC = WebViewController()
        webVC.loadWebPage(urlString)
        navigationController.pushViewController(webVC, animated: true)
    }
    
    func showSavedNews(_ savedArticles: [ArticleModelProtocol]) {
        let savedArticlesCoordinator = SavedArticlesCoordinator(navigationController: navigationController)
        childCoordinators.append(savedArticlesCoordinator)
        savedArticlesCoordinator.delegate = self
        savedArticlesCoordinator.start(savedArticles)
    }
    
    func logout() {
        delegate?.navigateToAuthorizationScene()
    }
    
}
// MARK: - SavedArticles Coordinator Coordinator Delegate
extension ProfileCoordinator: BackToProfileCoordinatorProtocol {
    func navigateBackToProfileCoordinator() {
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.popViewController(animated: true)
        childCoordinators.removeLast()
    }
}
