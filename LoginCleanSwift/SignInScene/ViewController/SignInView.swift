//
//  SIgnInView.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 03.04.2022.
//

import UIKit

protocol SignInViewInput: AnyObject {
    var delegate: SignInViewOutput? { get set }
    func displayUser(_ viewModel: SignInModel.ViewModel)
}

class SignInView: UIView {
    
    // MARK: - Properties
    weak var delegate: SignInViewOutput?
    
    // MARK: - UI Elements
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        return label
    }()
    
    private let loginTF: UITextField = {
       let tf = UITextField()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        tf.leftViewMode = .always
        tf.placeholder = "example@gmail.com"
        tf.layer.cornerRadius = 14
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.darkGray.cgColor
        return tf
    }()
    
    private let passwordTF: UITextField = {
       let tf = UITextField()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        tf.leftViewMode = .always
        tf.placeholder = "🔒"
        tf.layer.cornerRadius = 14
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.darkGray.cgColor
        return tf
    }()
    
    private var submitButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .medium
        configuration.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = configuration
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(loginDataSubmited), for: .touchUpInside)
        return button
    }()
    
    private var autoFillButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .medium
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .systemGreen
        
        let button = UIButton()
        button.configuration = configuration
        button.setTitle("AutoFill", for: .normal)
        button.addTarget(self, action: #selector(autoFillButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func loginDataSubmited() {
        delegate?.loginDataSubmited(login: loginTF.text!, password: passwordTF.text!)
    }
    
    @objc func autoFillButtonTapped() {
        delegate?.autofillButtonTapped()
    }
    
    // MARK: - Methods
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
    
    private func setupStacks(_ kind: StackKind) -> UIStackView {
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
        
        NSLayoutConstraint.activate([loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120),
                                     loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([loginTF.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor),
                                     loginTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     loginTF.heightAnchor.constraint(equalToConstant: 30),
                                     loginTF.widthAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([passwordLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 30),
                                     passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([passwordTF.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
                                     passwordTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     passwordTF.heightAnchor.constraint(equalToConstant: 30),
                                     passwordTF.widthAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([buttonStack.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 30),
                                     buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                                     buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)])
    }
    
}

// MARK: - SignInView Input
extension SignInView: SignInViewInput {
    func displayUser(_ viewModel: SignInModel.ViewModel) {
        loginTF.text = viewModel.login
        passwordTF.text = viewModel.password
    }
}
