//
//  AuthManager.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 12.04.2022.
//

import Foundation

class AuthManager {
    
    func register(user: UserModel) {
        UserDefaults.standard.set(user, forKey: user.login)
    }
    
    func signIn() {
        
    }
    
}
