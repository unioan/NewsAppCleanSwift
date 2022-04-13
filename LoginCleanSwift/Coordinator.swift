//
//  Coordinator.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 07.04.2022.
//

import UIKit

protocol Coodrinator {
    var childCoordinators: [Coodrinator] { get set }
    init(navigationController: UINavigationController)
    func start()
}

class AuthorizationCoordinator: Coodrinator {
    var childCoordinators: [Coodrinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signInVC = SignInViewController()
        signInVC.coordinator = self
        navigationController.viewControllers = [signInVC]
    }
    
}

// MARK: - SignInVC Coordinator Delegate (navigates sign in -> sign up)
extension AuthorizationCoordinator: SignInVCCoordinatorDelegate {
    func navigateToSignUpView() {
        let signUpVC = SignUpViewController()
        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }
}

extension AuthorizationCoordinator: SignUpVCCoordinatorDelegate {
    func navigateBackToSignInVC() {
        navigationController.popViewController(animated: true)
    }
}
