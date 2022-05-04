//
//  SignUpInteractor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.04.2022.
//

import Foundation

protocol SignUpBusinessLogic {
    var presentor: SignUpPresentationLogic? { get set }
    func saveUserAuthData(_ request: SignUpModel.RegisterUser.Request)
}

class SignUpInteractor {
    
    var presentor: SignUpPresentationLogic?
    
}

// MARK: - SignUpBusinessLogic
extension SignUpInteractor: SignUpBusinessLogic {
    func saveUserAuthData(_ request: SignUpModel.RegisterUser.Request) {
        PasswordManager.shared.register(user: request.userAuthData) {
            presentor?.successfullyRegistered()
        }
    }
}
