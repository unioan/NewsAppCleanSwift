//
//  SignUpPresentor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.04.2022.
//

import Foundation

protocol SignUpPresentationLogic {
    var viewController: SignUpViewDisplayLogic? { get set }
    func successfullyRegistered()
}

final class SignUpPresentor: SignUpPresentationLogic {
    
    weak var viewController: SignUpViewDisplayLogic?
    
    func successfullyRegistered() {
        viewController?.registrationFinished()
    }
    
}
