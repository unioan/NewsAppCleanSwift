//
//  SignInViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.04.2022.
//

import UIKit

protocol SignInDisplayLogic { // Presenter communicates with ViewController through this interface
    func displayUser(_ viewModel: SignInModels.ViewModel)
}

protocol SignInViewOutput: AnyObject { // View communicates with ViewController through this interface
    func signUpButtonTapped()
    func loginDataSubmited(login: String, password: String)
}


class SignInViewController: UIViewController {
    
    // MARK: - Properties
    weak var signInView: SignInViewInput?
    var interactor: SignInInteractor?
    var coordinator: AuthorizationCoordinator?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Authorization"
        navigationItem.backButtonTitle = "Back"
        
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
    func displayUser(_ viewModel: SignInModels.ViewModel) {
        signInView?.displayUser(viewModel)
    }
}

// MARK: - SignIn ViewOutput
extension SignInViewController: SignInViewOutput {
    func loginDataSubmited(login: String, password: String) {
        let userSubmitedData = SignInModels.Request(login: login, password: password)
        interactor?.fetchUser(userSubmitedData)
        // login: "11111@gmail.com", password: "111111"
    }
    
    func signUpButtonTapped() {
        coordinator?.navigateToSignUpView()
    }
}
