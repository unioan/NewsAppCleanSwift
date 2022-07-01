//
//  SignUpViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.04.2022.
//

import UIKit
import PhotosUI

protocol SignUpViewControllerCoordinatorDelegate {
    func navigateBackToSignInViewController()
    func showImagePickerController()
}

protocol SignUpViewOutput: AnyObject {
    func register(_ userAuthData: SignUpModel.RegisterUser.Request)
    func pickImage()
}

protocol SignUpViewDisplayLogic: AnyObject {
    func registrationFinished()
}

final class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    weak var signupView: SignUpViewInput?
    var interactor: SignUpBusinessLogic?
    var coordinator: SignUpViewControllerCoordinatorDelegate?
    
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
        signupView.delegate = self
        
        interactor.presentor = presentor
        presentor.viewController = self
        
        self.interactor = interactor
    }
    
}

// MARK: - SignUpView Output (sends data to view)
extension SignUpViewController: SignUpViewOutput {
    func pickImage() {
        coordinator?.showImagePickerController()
    }
    
    func register(_ signUpModelForRequest: SignUpModel.RegisterUser.Request) {
        interactor?.saveUserAuthData(signUpModelForRequest)
    }

}

extension SignUpViewController: SignUpViewDisplayLogic {
    func registrationFinished() {
        coordinator?.navigateBackToSignInViewController()
    }

}

extension SignUpViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self,
                          let image = image as? UIImage else { return }
                    self.signupView?.setImageToPhotoView(image)
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    
}
