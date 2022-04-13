//
//  SignUpView.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.04.2022.
//

import UIKit

protocol SignUpViewInput: AnyObject {
    var delegate: SignUpViewOutput? { get set }
}

class SignUpView: UIView {
    
    // MARK: - Properties
    weak var delegate: SignUpViewOutput?
    
    private let photoView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemYellow
        iv.layer.cornerRadius = 140 / 2
        iv.clipsToBounds = true
        return iv
    }()
    
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Number"
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
        return tf
    }()
    
    private let nameTF: UITextField = {
        let tf = UITextField()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        tf.leftViewMode = .always
        tf.placeholder = "Jack Willson"
        tf.layer.cornerRadius = 20
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.darkGray.cgColor
        return tf
    }()
    
    private let numberTF: UITextField = {
        let tf = UITextField()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        tf.leftViewMode = .always
        tf.placeholder = "+ 7"
        tf.layer.cornerRadius = 20
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.darkGray.cgColor
        return tf
    }()
    
    private var registerButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .medium
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .systemGreen
        
        let button = UIButton()
        let attributes = NSAttributedString(string: "Submit", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        button.setAttributedTitle(attributes, for: .normal)
        button.configuration = configuration
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func registerButtonPressed() {
        delegate
    }
    
    // MARK: - Helpers
    func setupViews() {
        addSubViewsAndTamicOff([photoView, loginLabel, passwordLabel, nameLabel, numberLabel,
                                           loginTF, passwordTF, nameTF, numberTF, registerButton])
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([photoView.topAnchor.constraint(equalTo: topAnchor, constant: 110),
                                     photoView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     photoView.heightAnchor.constraint(equalToConstant: 140),
                                     photoView.widthAnchor.constraint(equalToConstant: 140)])
        
        NSLayoutConstraint.activate([loginLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor,
                                                                     constant: photoView.frame.maxY - safeAreaInsets.top + 35),
                                     loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([passwordLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 35),
                                     passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 35),
                                     nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 35),
                                     numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([loginTF.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor),
                                     loginTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     loginTF.heightAnchor.constraint(equalToConstant: 40),
                                     loginTF.widthAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([passwordTF.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
                                     passwordTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     passwordTF.heightAnchor.constraint(equalToConstant: 40),
                                     passwordTF.widthAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([nameTF.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
                                     nameTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     nameTF.heightAnchor.constraint(equalToConstant: 40),
                                     nameTF.widthAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([numberTF.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
                                     numberTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     numberTF.heightAnchor.constraint(equalToConstant: 40),
                                     numberTF.widthAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([registerButton.topAnchor.constraint(equalTo: numberTF.bottomAnchor, constant: 30),
                                     registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                                     registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                                     registerButton.heightAnchor.constraint(equalToConstant: 40)])
    }
    
}

// MARK: - SignUpView Input (recives data from VC)
extension SignUpView: SignUpViewInput {
    
    
    
}
