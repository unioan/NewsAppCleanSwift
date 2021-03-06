//
//  SignInViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.04.2022.
//

import UIKit

protocol SignInDisplayLogic { // Presenter communicates with ViewController through this interface
    func displayUser(_ viewModel: SignInModels.ViewModel)
    func presentAllert(_ alertKind: AlertKind)
}

protocol SignInViewOutput: AnyObject  { // View communicates with ViewController through this interface
    func signUpButtonTapped()
    func loginDataSubmited(login: String, password: String)
}

protocol AuthorizationCoordinateDelegate: AnyObject { // Talks to coordinator
    func navigateToSignUpView()
}


final class SignInViewController: UIViewController {
    
    // MARK: - Properties
    weak var signInView: SignInViewInput?
    var alertView: AlertView?
    
    var interactor: SignInInteractor?
    weak var authorizationCoordinator: AuthorizationCoordinator?
    
    var state: SignInStage = .logIn
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Authorization"
        navigationItem.backButtonTitle = "Back"
        
        setupDependencies()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.dissmissAlert()
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
    
    func presentAlertAndHideKeybord(_ alertKind: AlertKind) {
        alertView = AlertView(frame: .zero)
        alertView?.presentAlert(alertKind: alertKind, viewController: self)
        signInView?.hideKeybord()
    }
    
    func dissmissAlert() {
        alertView?.dismissAlert(from: self)
        alertView = nil
    }
    
}

// MARK: - Methods triggered by view
extension SignInViewController: SignInViewOutput {
    func loginDataSubmited(login: String, password: String) {
        let userSubmitedData = SignInModels.Request(login: login, password: password)
        interactor?.fetchUser(userSubmitedData)
    }
    
    func signUpButtonTapped() {
        authorizationCoordinator?.navigateToSignUpView()
    }
}

// MARK: - Methods triggered by presentor
extension SignInViewController: SignInDisplayLogic {
    func displayUser(_ viewModel: SignInModels.ViewModel) {
        signInView?.displayUser(viewModel)
        presentAlertAndHideKeybord(.succsess)
        authorizationCoordinator?.navigateToProfile(viewModel.userModel)
    }
    
    func presentAllert(_ alertKind: AlertKind) {
        presentAlertAndHideKeybord(alertKind)
    }
}


