//
//  SignInViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.04.2022.
//

import UIKit

protocol SignInDisplayLogic { // Presenter communicates with ViewController through this interface
    func displayUser(_ viewModel: SignInModel.ViewModel)
}

protocol SignInViewOutput: AnyObject { // View communicates with ViewController through this interface
    func autofillButtonTapped()
    func loginDataSubmited(login: String, password: String)
}

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    weak var signInView: SignInViewInput?
    var interactor: SignInInteractor!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        
        setupDependencies()
    }
    
    // MARK: - Methods
    func setupDependencies() {
        let signInView = SignInView()
        view = signInView
        signInView.delegate = self
        self.signInView = signInView
        
        let interactor = SignInInteractor()
        let presenter = SignInPresenter()
        
        self.interactor = interactor
        interactor.presentor = presenter
        presenter.viewController = self
    }
}

// MARK: - SignIn DisplayLogic
extension SignInViewController: SignInDisplayLogic {
    func displayUser(_ viewModel: SignInModel.ViewModel) {
        signInView?.displayUser(viewModel)
    }
}

// MARK: - SignIn ViewOutput
extension SignInViewController: SignInViewOutput {
    func loginDataSubmited(login: String, password: String) {
        let userSubmitedData = SignInModel.Request(login: login, password: password)
        interactor?.fetchUser(userSubmitedData)
    }
    
    func autofillButtonTapped() {
        print("ViewController autofillButton - Tapped!")
        interactor?.fetchUser(SignInModel.Request(login: "11111@gmail.com", password: "111111"))
    }
}
