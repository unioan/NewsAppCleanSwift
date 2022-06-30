//
//  SignInPresenter.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.04.2022.
//

import Foundation

protocol SignInPresentationLogic {
    func present(_ state: SignInState)
}

enum SignInState {
    case success(SignInModels.Response)
    case error(LoginError)
}

class SignInPresenter: SignInPresentationLogic {
    
    
    // MARK: - Properties
    var viewController: SignInDisplayLogic!
    
    
    // MARK: - Life Cycle
    deinit {
        print("SignInPresenter dealocate from memory")
    }
    
    
    // MARK: - Methods
    func present(_ state: SignInState) {
        switch state {
        case .success(let response):
            var viewModel = SignInModels.ViewModel(response.userModel)
            viewModel.login = response.login
            viewModel.password = ""
            viewController?.displayUser(viewModel)
        case .error(let error):
            switch error {
            case .wrongEmail:
                viewController.presentAllert(AlertKind.error(error))
                print("DEBUG::: Wrong email")
            case .wrongPassword:
                viewController.presentAllert(AlertKind.error(error))
                print("DEBUG::: Wrong password")
            }
        }
    }
    
}
    

