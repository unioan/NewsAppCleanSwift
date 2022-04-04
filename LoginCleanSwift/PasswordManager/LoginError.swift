//
//  LoginError.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 04.04.2022.
//

import Foundation

enum LoginError: String, Error {
    case wrongEmail = "Please, check your login"
    case wrongPassword = "Please, check your password"
}
