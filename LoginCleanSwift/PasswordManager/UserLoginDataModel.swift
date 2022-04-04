//
//  UserLoginData.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 04.04.2022.
//

import Foundation

struct UserLoginDataModel: Codable {
    let login: String
    let password: String
    
    init(_ request: SignInModel.Request) {
        login = request.login
        password = request.password
    }
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
}
