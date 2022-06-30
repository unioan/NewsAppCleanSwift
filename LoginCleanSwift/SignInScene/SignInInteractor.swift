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

class SignInInteractor: SignInBusinessLogic {
    
    // MARK: - Properties
    var presentor: SignInPresentationLogic!
    var state = true
    
    // MARK: - Life Cycle
    deinit {
        print("SignInInteractor dealocate from memory")
    }
    
    // MARK: - Methods
    func fetchUser(_ request: SignInModels.Request) {
        
        PasswordManager.shared.signIn(with: request) { result in
            switch result {
            case .success(let userModel):
                let response = SignInModels.Response(userModel)
                presentor.present(.success(response))
            case .failure(let error):
                presentor.present(.error(error))
            }
        }
    }
    
}
