//
//  ProfileViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import UIKit

protocol ProfileViewOUTPUTDelegate: AnyObject {
    var onInput: ((_ userModel: UserModel) -> ())? { get set }
    func changePhone()
}

protocol ProfileVCCoordinatorDelegate: AnyObject {
    func logout()
}

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var profileView: ProfileView?
    var interactor: ProfileInteractor?
    weak var profileCoordinator: ProfileVCCoordinatorDelegate?
    
    var userModel: UserModel? {
        willSet { profileView?.onInput(newValue) }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
        setUpNavigationBackButton()
        setupDependencies()
        
        profileView?.onInput(userModel)

    }
    
    // MARK: - Actions
    @objc func backButtonTapped() {
        profileCoordinator?.logout()
    }
    
    // MARK: - Methods
    func setUpNavigationBackButton() {
        let backButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setupDependencies() {
        profileView = ProfileView()
        view = profileView
        
        self.interactor = ProfileInteractor()
    }
    
}
