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
    
    func register(user: UserModel, completion: () -> ()) {
        if  defaults.object(forKey: user.login) == nil {
            defaults.set(user, forKey: user.login)
            defaults.set(UserAuthData(login: user.login, password: user.password), forKey: user.login)
            completion()
        }
    }
    
    func login(user: UserAuthData, completion: (Result<UserModel, LoginError>) -> ()) {
       
        let userModel: UserModel? = defaults.object(for: user.login, logType: .userModel)
        
        guard let userObject = defaults.object(forKey: user.login) as? Data,
        let userModel = defaults.object(forKey: user.login) as? Data else {
            completion(.failure(.wrongEmail))
            return
        }

        let authUser = try! decoder.decode(UserModel.self, from: userObject)
        let userModel = try! decoder.decode(UserModel.self, from: userObject)
        
        if user.password == authUser.password {
            completion(.success(registeredUser))
        }

    }
    
    func saveLoginAndPassword(login: String, password: String) {
        let registeredUser = UserAuthData(login: login, password: password)
        let data = try! encoder.encode(registeredUser)
        defaults.setValue(data, forKey: login)
    }
    
    func checkPassword(for user: UserAuthData, result: (Result<UserAuthData, LoginError>) -> ()) {
        guard let userObject = defaults.object(forKey: user.login) as? Data else {
            result(.failure(.wrongEmail))
            return
        }
        
        let registeredUser = try! decoder.decode(UserAuthData.self, from: userObject)
        if user.password == registeredUser.password {
            result(.success(user))
        }
    }
    
}
