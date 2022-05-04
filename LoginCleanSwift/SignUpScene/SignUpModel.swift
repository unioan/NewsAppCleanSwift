//
//  SignUpModel.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.04.2022.
//

import Foundation

enum SignUpModel {
    
    enum RegisterUser {
        
        struct Request {
            let userAuthData: UserAuthData
        }
        
        struct Response {
            let name: String
            let email: String
            let phone: String
            
            init(_ profileData: SignUpModel.RegisterUser.Request) {
                self.name = profileData.userAuthData.userModel?.name ?? "No name"
                self.email = profileData.userAuthData.login
                self.phone = profileData.userAuthData.userModel?.number ?? "No phone"
            }
        }
        
        struct ViewModel {
            
        }
    }

    
}
