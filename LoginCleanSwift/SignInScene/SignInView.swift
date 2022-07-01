//
//  SIgnInView.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 03.04.2022.
//

import UIKit

protocol SignInViewInput: AnyObject {
    func displayUser(_ viewModel: SignInModels.ViewModel)
    func hideKeybord()
}

final class SignInView: UIView {
    
    // MARK: - Properties
    weak var delegate: SignInViewOutput?
    
    // MARK: - UI Elements
    private let loginLabel: UILabel = {
        let label = UILabel()
        let title = NSAttributedString(string: "Login", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        label.attributedText = title
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        let title = NSAttributedString(string: "Password", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        label.attributedText = title
        return label
    }()
    
    private let loginTF: UITextField = {
       let tf = UITextField()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        tf.leftViewMode = .always
        tf.placeholder = "example@gmail.com"
        tf.layer.cornerRadius = 20
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.darkGray.cgColor
        return tf
    }()
    
    private let passwordTF: UITextField = {
       let tf = UITextField()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        tf.leftViewMode = .always
        tf.placeholder = "🔒"
        tf.layer.cornerRadius = 20
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private var submitButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .medium
        configuration.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = configuration
        let attributes = NSAttributedString(string: "Log in", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        button.setAttributedTitle(attributes, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var autoFillButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .medium
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .systemGreen
        
        let button = UIButton()
        button.configuration = configuration
        let attributes = NSAttributedString(string: "Sign up", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        button.setAttributedTitle(attributes, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        passwordTF.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func loginButtonTapped() {
        guard let lowercasedLogin = loginTF.text?.lowercased(),
              let password = passwordTF.text else { return }
        print("DEBUG::: login: \(lowercasedLogin) and password: \(password) entered to SignInView ")
        delegate?.loginDataSubmited(login: lowercasedLogin, password: password)
    }
    
    @objc func signUpButtonTapped() {
        delegate?.signUpButtonTapped()
    }
    
    // MARK: - Helpers
    func setupViews() {
        backgroundColor = .white
        
        addSubview(loginLabel)
        addSubview(loginTF)
        addSubview(passwordLabel)
        addSubview(passwordTF)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTF.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStacks(_ kind: SignInStackView) -> UIStackView {
        switch kind {
        case .loginButtons:
            let buttonStack = UIStackView(arrangedSubviews: [submitButton, autoFillButton])
            buttonStack.translatesAutoresizingMaskIntoConstraints = false
            addSubview(buttonStack)
            buttonStack.axis = .horizontal
            buttonStack.alignment = .fill
            buttonStack.distribution = .fill
            buttonStack.spacing = 12
            return buttonStack
        }
    }
    
    private func setupConstraints() {
        
        let buttonStack = setupStacks(.loginButtons)
        
        NSLayoutConstraint.activate([loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: 140),
                                     loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([loginTF.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor),
                                     loginTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     loginTF.heightAnchor.constraint(equalToConstant: 40),
                                     loginTF.widthAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([passwordLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 35),
                                     passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([passwordTF.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
                                     passwordTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     passwordTF.heightAnchor.constraint(equalToConstant: 40),
                                     passwordTF.widthAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([buttonStack.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 30),
                                     buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                                     buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     buttonStack.heightAnchor.constraint(equalToConstant: 40)])
    }
    
}

// MARK: - SignInView Input
extension SignInView: SignInViewInput {
    func hidePasswordTFPlaceholder() {
        passwordTF.placeholder = ""
    }
    
    func hideKeybord() {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    func displayUser(_ viewModel: SignInModels.ViewModel) {
        loginTF.text = viewModel.login
        passwordTF.text = viewModel.password
    }
}

extension SignInView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTF.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text == " " || textField.text == "" {
            passwordTF.placeholder = "🔒"
        }
    }
}
