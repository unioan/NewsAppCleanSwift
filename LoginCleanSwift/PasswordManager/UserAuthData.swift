//
//  UserLoginData.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 04.04.2022.
//

import Foundation

enum LogType {
    case userAuthData
    case userModel
}

struct UserAuthData: Codable {
    let login: String
    let password: String
    var userModel: UserModel?
    
    init(_ request: SignInModels.Request) {
        login = request.login
        password = request.password
    }
    
    init(login: String, password: String, userModel: UserModel) {
        self.login = login
        self.password = password
        self.userModel = userModel
    }
    
}

struct UserModel: Codable {
    let login: String
    let password: String
    let name: String
    let number: String
    let photo: Data
}





