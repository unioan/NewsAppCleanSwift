//
//  SignInInteractor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.04.2022.
//

import Foundation

protocol SignInBusinessLogic {
    func fetchUser(_ request: SignInModels.Request)
}

protocol SignInVCCoordinatorDelegate: AnyObject { // Talks to coordinator
    func navigateToSignUpView()
}

class SignInInteractor: SignInBusinessLogic {
    
    // MARK: - Properties
    var presentor: SignInPresentationLogic!
    weak var coordinator: SignInVCCoordinatorDelegate?
    
    // MARK: - Life Cycle
    deinit {
        print("SignInInteractor dealocate from memory")
    }
    
    // MARK: - Methods
    func fetchUser(_ request: SignInModels.Request) {
        let userLoginDataModel = UserAuthData(request)
        let viewModel = SignInModels.ViewModel(login: request.login, password: request.password)
        
        PasswordManager.shared.checkPassword(for: userLoginDataModel) { result in
            switch result {
            case .success(_):
                presentor.presentUser(viewModel)
            case .failure(let error):
                presentor.presentError(error, for: viewModel)
            }
        }
    }
    
    func navigateToSignUpViewController() {
        print("navigateToSignUpViewController SignInInteractor - TAPPED! / coordinator \(coordinator)")
        coordinator?.navigateToSignUpView()
    }
    
}
