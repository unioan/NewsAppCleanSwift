//
//  SignUpViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.04.2022.
//

import UIKit

protocol SignUpViewOutput: AnyObject {
    func register(_ userAuthData: SignUpModel.RegisterUser.Request)
}

protocol SignUpViewDisplayLogic: AnyObject {
    
}

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    weak var signupView: SignUpViewInput?
    var interactor: SignUpBusinessLogic?
    var coordinator: AuthorizationCoordinator?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registration"
        
        setupDependencies()
    }
    
    func setupDependencies() {
        let signupView = SignUpView()
        let interactor = SignUpInteractor()
        let presentor = SignUpPresentor()
        
        view = signupView
        self.signupView = signupView
        
        interactor.presentor = presentor
        presentor.viewController = self
        
        self.interactor = interactor
    }
    
}

// MARK: - SignUpView Output (sends data to view)
extension SignUpViewController: SignUpViewOutput {
    func register(_ userAuthData: SignUpModel.RegisterUser.Request) {
        interactor?.saveUserAuthData(userAuthData)
    }
    
    
}

extension SignUpViewController: SignUpViewDisplayLogic {
    
}

