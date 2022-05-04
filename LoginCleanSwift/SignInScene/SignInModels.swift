//
//  SignInModel.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.04.2022.
//

import Foundation

enum SignInModels {
    
    struct Request {
        let login: String
        let password: String
    }
    
    struct Response {
        let login: String
        let password: String
        let userModel: UserModel
        
        init(_ userModel: UserModel) {
            login = userModel.login
            password = userModel.password
            self.userModel = userModel
        }
    }
    
    struct ViewModel {
        var login: String
        var password: String
        let userModel: UserModel
        
        init(_ userModel: UserModel) {
            login = userModel.login
            password = userModel.password
            self.userModel = userModel
        }
    }
    
}
