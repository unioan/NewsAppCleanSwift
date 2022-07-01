//
//  AuthorizationCoordinator.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 20.04.2022.
//

import UIKit
import PhotosUI

final class AuthorizationCoordinator: Coodrinator {
    var childCoordinators: [Coodrinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signInVC = SignInViewController()
        signInVC.authorizationCoordinator = self
        navigationController.viewControllers = [signInVC]
        
        if PasswordManager.shared.isLoged {
            let profileVC = ProfileViewController()
            navigationController.isNavigationBarHidden = true // Create separate coordinator for profile
            navigationController.viewControllers.append(profileVC)
        }
    }
    
}

// MARK: - SignInVC Coordinator Delegate (navigates sign in -> sign up)
extension AuthorizationCoordinator: AuthorizationCoordinateDelegate {
    func navigateToSignUpView() {
        let signUpVC = SignUpViewController()
        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func navigateToProfile(_ userModel: UserModel) {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        childCoordinators.append(profileCoordinator)
        profileCoordinator.delegate = self
        profileCoordinator.start(userModel)
    }
}

// MARK: - SignUpVC Coordinator Delegate
extension AuthorizationCoordinator: SignUpViewControllerCoordinatorDelegate {
    func navigateBackToSignInViewController() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showImagePickerController() {
        guard let signUpVC = navigationController.viewControllers.last as? SignUpViewController else { return }
        
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = signUpVC
        signUpVC.present(picker, animated: true)
    }
    
}

// MARK: - Profile Coordinator Delegate
extension AuthorizationCoordinator: BackToAuthorizstionCoordinateDelegate {
    func navigateToAuthorizationScene() {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
    
}
