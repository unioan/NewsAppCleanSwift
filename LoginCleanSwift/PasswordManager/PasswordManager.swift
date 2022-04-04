//
//  PasswordManager.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 04.04.2022.
//

import Foundation

class PasswordManager {
    
    private var defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    class var shared: PasswordManager {
        struct Static {
            static let instance = PasswordManager()
        }
        return Static.instance
    }
    
    func createTestAccount() {
        saveLoginAndPassword(login: "11111@gmail.com", password: "11111")
    }
    
    func saveLoginAndPassword(login: String, password: String) {
        let registeredUser = UserLoginDataModel(login: login, password: password)
        let data = try! encoder.encode(registeredUser)
        defaults.setValue(data, forKey: login)
    }
    
    func checkPassword(for user: UserLoginDataModel, result: (Result<UserLoginDataModel, LoginError>) -> ()) {
        guard let userObject = defaults.object(forKey: user.login) as? Data else {
            result(.failure(.wrongEmail))
            return
        }
        
        let registeredUser = try! decoder.decode(UserLoginDataModel.self, from: userObject)
        if user.password == registeredUser.password {
            result(.success(user))
        }
    }
    
}
