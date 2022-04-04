//
//  SignInPresenter.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.04.2022.
//

import Foundation

protocol SignInPresentationLogic {
    func presentUser(_ response: SignInModel.ViewModel)
    func presentError(_ error: LoginError, for response: SignInModel.ViewModel)
}

class SignInPresenter: SignInPresentationLogic {
    
    // MARK: - Properties
    var viewController: SignInDisplayLogic!
    
    // MARK: - Life Cycle
    deinit {
        print("SignInPresenter dealocate from memory")
    }
    
    // MARK: - Methods
    func presentUser(_ response: SignInModel.ViewModel) {
        let login = "✅ " + response.login
        let password = "✅ " + response.password
        let viewModel = SignInModel.ViewModel(login: login, password: password)
        viewController?.displayUser(viewModel)
    }
    
    func presentError(_ error: LoginError, for response: SignInModel.ViewModel) {
        switch error {
        case .wrongEmail:
            let login = "❌ " + response.login
            let password = response.password
            let viewModel = SignInModel.ViewModel(login: login, password: password)
            viewController?.displayUser(viewModel)
        case .wrongPassword:
            let login = "✅ " + response.login
            let password = response.password
            let viewModel = SignInModel.ViewModel(login: login, password: password)
            viewController?.displayUser(viewModel)
        }
    }

}
