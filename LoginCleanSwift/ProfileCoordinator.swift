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

class ProfileCoordinator: Coodrinator {
    
    var childCoordinators: [Coodrinator] = []
    weak var delegate: BackToAuthorizstionCoordinateDelegate?
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileVC = ProfileViewController()
        profileVC.profileCoordinator = self
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func start(_ userModel: UserModel) {
        let profileVC = ProfileViewController()
        profileVC.userModel = userModel 
        profileVC.profileCoordinator = self
        navigationController.pushViewController(profileVC, animated: true)
    }
}



extension ProfileCoordinator: ProfileVCCoordinatorDelegate {
    func showWebPage(_ urlString: String) {
        let webVC = WebViewController()
        webVC.loadWebPage(urlString)
        navigationController.pushViewController(webVC, animated: true)
    }
    
    func showSavedNews() {
        let vc = SavedNewsTableViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func logout() {
        delegate?.navigateToAuthorizationScene()
    }
    
    
    
}
