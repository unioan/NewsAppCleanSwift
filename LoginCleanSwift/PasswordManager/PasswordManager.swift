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
    
    var isLoged: Bool { return logged }
    var userLogin: String = ""
    
    class var shared: PasswordManager {
        struct Static {
            static let instance = PasswordManager()
        }
        return Static.instance
    }
    
    func register(user: UserAuthData, completion: () -> ()) {
        if  defaults.object(forKey: user.login) == nil {
            let userData = try! JSONEncoder().encode(user)
            defaults.set(userData, forKey: user.login)
            completion()
        }
    }
    
    func signIn(with request: SignInModels.Request, completion: (Result<UserModel, LoginError>) -> ()) {
        guard let userData = defaults.object(forKey: request.login) as? Data,
              let userAuthData = try? JSONDecoder().decode(UserAuthData.self, from: userData)  else {
                  completion(.failure(.wrongEmail))
                  return
        }

        guard let userModel = userAuthData.userModel, request.password == userAuthData.password else { // Verifies password & gets model
            completion(.failure(.wrongPassword))
            return
        }
        logged.toggle()
        userLogin = request.login
        completion(.success(userModel))
    }
    
    
    
}
