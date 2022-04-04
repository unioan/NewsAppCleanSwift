//
//  SignInInteractor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.04.2022.
//

import Foundation

protocol SignInBusinessLogic {
    func fetchUser(_ request: SignInModel.Request)
}

class SignInInteractor: SignInBusinessLogic {
    
    // MARK: - Properties
    var presentor: SignInPresentationLogic!
    
    // MARK: - Life Cycle
    deinit {
        print("SignInInteractor dealocate from memory")
    }
    
    // MARK: - Methods
    func fetchUser(_ request: SignInModel.Request) {
        let userLoginDataModel = UserLoginDataModel(request)
        let viewModel = SignInModel.ViewModel(login: request.login, password: request.password)
        
        PasswordManager.shared.checkPassword(for: userLoginDataModel) { result in
            switch result {
            case .success(_):
                presentor.presentUser(viewModel)
            case .failure(let error):
                presentor.presentError(error, for: viewModel)
            }
        }
    }
    
}
