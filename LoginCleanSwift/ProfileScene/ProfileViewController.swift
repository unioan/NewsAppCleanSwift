//
//  ProfileViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var interactor: ProfileInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    func setupDependencies() {
        let profileView = ProfileView()
        view = profileView
        
        self.interactor = ProfileInteractor()
    }
    
}
