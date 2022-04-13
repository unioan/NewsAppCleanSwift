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
    }
    
    struct ViewModel {
        let login: String
        let password: String
    }
    
}
