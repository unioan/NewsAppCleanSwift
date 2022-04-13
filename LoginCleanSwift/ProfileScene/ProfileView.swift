//
//  ProfileView.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - Properties
    private let photoView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemYellow
        iv.layer.cornerRadius = 140 / 2
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "mickey_mouse")
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSAttributedString(string: "Vladimir Yushkovrgrgegeg", attributes: [.font: UIFont.boldSystemFont(ofSize: 22)])
        label.attributedText = attributedText
        return label
    }()
    
    private let emailIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "mail")
        iv.tintColor = .darkGray
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        return label
    }()
    
    private let phoneIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "phone")
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .darkGray
        return iv
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Number"
        return label
    }()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
        setupConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func setupStacks(_ kind: ProfileViewStack) -> UIStackView {
        switch kind {
        case .emailLine:
            let emileStack = UIStackView(arrangedSubviews: [emailIcon, emailLabel])
            addSubview(emileStack)
            emileStack.translatesAutoresizingMaskIntoConstraints = false
            emileStack.axis = .horizontal
            emileStack.spacing = 15
            emileStack.setContentHuggingPriority(.required, for: .horizontal)
            return emileStack
        case .phoneLine:
            let phoneStack = UIStackView(arrangedSubviews: [phoneIcon, phoneNumberLabel])
            addSubview(phoneStack)
            phoneStack.translatesAutoresizingMaskIntoConstraints = false
            phoneStack.axis = .horizontal
            phoneStack.spacing = 15
            phoneStack.setContentHuggingPriority(.required, for: .horizontal)
            return phoneStack
        }
    }
    
    private func setupViews() {
        addSubViewsAndTamicOff([photoView, nameLabel, emailIcon, emailLabel, phoneIcon, phoneNumberLabel])
    }
    
    private func setupConstrints() {
        let emailStack = setupStacks(.emailLine)
        let phoneStack = setupStacks(.phoneLine)
        
        let nameStack = UIStackView(arrangedSubviews: [nameLabel])
        nameStack.axis = .vertical

        let emailPhoneStack = UIStackView(arrangedSubviews: [emailStack, phoneStack])
        emailPhoneStack.axis = .vertical
        emailPhoneStack.alignment = .leading
        emailPhoneStack.distribution = .fill
        emailPhoneStack.spacing = 6

        let infoStack = UIStackView(arrangedSubviews: [nameStack, emailPhoneStack])
        infoStack.spacing = 12
        infoStack.axis = .vertical
        infoStack.alignment = .leading
        infoStack.setContentHuggingPriority(.required, for: .horizontal)
        addSubViewsAndTamicOff([infoStack])

        let userDataStack = UIStackView(arrangedSubviews: [photoView, infoStack])
        userDataStack.axis = .horizontal
        userDataStack.alignment = .leading
        userDataStack.setContentHuggingPriority(.required, for: .horizontal)
        addSubViewsAndTamicOff([userDataStack])
        
        
        NSLayoutConstraint.activate([userDataStack.topAnchor.constraint(equalTo: topAnchor, constant: 60),
                                     userDataStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
                                     userDataStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)])
        
        NSLayoutConstraint.activate([photoView.heightAnchor.constraint(equalToConstant: 140),
                                     photoView.widthAnchor.constraint(equalToConstant: 140)])
        
        NSLayoutConstraint.activate([emailIcon.heightAnchor.constraint(equalToConstant: 20),
                                     emailIcon.widthAnchor.constraint(equalToConstant: 20),
                                     phoneIcon.heightAnchor.constraint(equalToConstant: 20),
                                     phoneIcon.widthAnchor.constraint(equalToConstant: 20)])
    }
    
}
