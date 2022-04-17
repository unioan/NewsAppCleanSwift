//
//  PasswordManager.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 04.04.2022.
//

import Foundation

class PasswordManager {
    
    private var logged = false
    private var defaults = UserDefaults.standard
    
    class var shared: PasswordManager {
        struct Static {
            static let instance = PasswordManager()
        }
        return Static.instance
    }
    
    func isLoged() -> Bool {
        return logged
    }
    
    func register(user: UserModel, completion: () -> ()) {
        if  defaults.object(forKey: user.login) == nil {
            let userAuth = UserAuthData(user)
            defaults.set(userAuth, forKey: user.login)
            completion()
        }
    }
    
    func signIn(with request: SignInModels.Request, completion: (Result<UserModel, LoginError>) -> ()) {
        guard let userAuthData = defaults.object(forKey: request.login) as? UserAuthData else { // Gain UserAuth object
            completion(.failure(.wrongEmail))
            return
        }
        guard let userModel = userAuthData.userModel, request.password == userAuthData.password else { // Verifies password & gets model
            completion(.failure(.wrongPassword))
            return
        }
        logged.toggle()
        completion(.success(userModel))
    }
    
    
    
}
