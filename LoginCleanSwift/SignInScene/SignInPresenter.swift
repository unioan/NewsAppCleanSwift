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
            viewModel.login = "✅ " + response.login
            viewModel.password = "✅ " + response.password
            viewController?.displayUser(viewModel)
        case .error(let error):
            switch error {
            case .wrongEmail:
                print("")
            case .wrongPassword:
                print("")
            }
        }
    }
    
}
        
//        func presentUser(_ response: SignInModels.ViewModel) {
//            let login = "✅ " + response.login
//            let password = "✅ " + response.password
//            let viewModel = SignInModels.ViewModel(login: login, password: password)
//            viewController?.displayUser(viewModel)
//        }
//
//        func presentError(_ error: LoginError, for response: SignInModels.ViewModel) {
//            switch error {
//            case .wrongEmail:
//                let login = "❌ " + response.login
//                let password = response.password
//                let viewModel = SignInModels.ViewModel(login: login, password: password)
//                viewController?.displayUser(viewModel)
//            case .wrongPassword:
//                let login = "✅ " + response.login
//                let password = response.password
//                let viewModel = SignInModels.ViewModel(login: login, password: password)
//                viewController?.displayUser(viewModel)
//            }
//        }
        
    

