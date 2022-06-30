//
//  AlertView.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 28.06.2022.
//

import UIKit

enum AlertKind {
    case error(LoginError)
    case succsess
}

final class AlertView: UIView {
    
    private var alertKind: AlertKind
    private weak var viewController: UIViewController?
    private static var alertIsShown = false
    
    private let alertCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: -3, height: 5)
        return view
    }()
    
    private let alertLabelImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let errorName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let errorDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let spinerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        return spinner
    }()
    
    private let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        var stack: UIStackView
        switch alertKind {
        case .error(let loginError):
            stack = UIStackView(arrangedSubviews: [alertButton])
        case .succsess:
            stack = UIStackView(arrangedSubviews: [alertButton, spinerView])
            stack.spacing = 6
            stack.axis = .horizontal
        }
        return stack
    }()
    
    
    // MARK: - Life Cycle
    private init(alertKind: AlertKind, viewController: UIViewController) {
        self.alertKind = alertKind
        self.viewController = viewController
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
        setAppearance(alertKind)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func tryAgainButtonTapped() {
        if case AlertKind.error = alertKind {
            guard let signInVC = viewController as? SignInViewController else { return }
            signInVC.dissmissAlert()
        } else {
            alertButton.isUserInteractionEnabled = false
        }
    }
    
    // MARK: - Static Methods
    static func presentAlert(alertKind: AlertKind, viewController: UIViewController) {
        if !alertIsShown {
            AlertView(alertKind: alertKind, viewController: viewController)
            alertIsShown.toggle()
        }
    }
    
    static func dismissAlert(from viewController: UIViewController?) {
        if alertIsShown {
            guard let viewController = viewController else { return }
            let alert = viewController.view.subviews.last
            alert?.removeFromSuperview()
            alertIsShown.toggle()
        }
    }
    
    // MARK: - Instance Methods
    private func setAppearance(_ alertKind: AlertKind) {
        switch alertKind {
        case .error(let loginError):
            alertLabelImageView.image = UIImage(named: "RedCross")
            
            let attributes = NSAttributedString(string: "Try again", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
            alertButton.setAttributedTitle(attributes, for: .normal)
            alertButton.setTitleColor(.systemRed, for: .normal)
            if loginError == .wrongEmail {
                errorName.text = "Wrong login"
                errorDescription.text = "Please, make sure you have entered correct login"
            } else if loginError == .wrongPassword {
                errorName.text = "Wrong password"
                errorDescription.text = "Please, check your password and try again"
            }
        case .succsess:
            alertLabelImageView.image = UIImage(named: "GreenTick")
            
            let attributes = NSAttributedString(string: "Loading", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
            alertButton.setAttributedTitle(attributes, for: .normal)
            alertButton.setTitleColor(.black, for: .normal)
            
            errorName.text = "You have successfully loged in!"
            errorDescription.text = "Please, wait until your news feed is loaded"
        }
    }
    
    private func setupViews() {
        layer.opacity = 0.99
        addSubViewsAndTamicOff([alertCardView])
        frame = (viewController?.view.bounds)!
        viewController?.view.addSubview(self)
        
        alertCardView.addSubViewsAndTamicOff([alertLabelImageView, errorName, errorDescription, buttonStack])
    }
    
    private func setupConstraints() {
        let tabBarTopInset = (viewController?.view.safeAreaInsets.top)!
        NSLayoutConstraint.activate([alertCardView.heightAnchor.constraint(equalToConstant: 200),
                                     alertCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     alertCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     alertCardView.topAnchor.constraint(equalTo: topAnchor, constant: tabBarTopInset + 35)])
        
        var dinamicLabelSize: CGFloat {
            switch alertKind {
            case .error(_): return 52
            case .succsess: return 150
            }
        }
        
        NSLayoutConstraint.activate([alertLabelImageView.heightAnchor.constraint(equalToConstant: dinamicLabelSize),
                                     alertLabelImageView.widthAnchor.constraint(equalToConstant: dinamicLabelSize),
                                     alertLabelImageView.centerXAnchor.constraint(equalTo: alertCardView.centerXAnchor),
                                     alertLabelImageView.topAnchor.constraint(equalTo: alertCardView.topAnchor, constant: -(dinamicLabelSize / 2))])
        
        NSLayoutConstraint.activate([errorName.topAnchor.constraint(equalTo: alertCardView.topAnchor,
                                                                    constant: 32),
                                     errorName.centerXAnchor.constraint(equalTo: alertCardView.centerXAnchor)])
        
        NSLayoutConstraint.activate([errorDescription.topAnchor.constraint(equalTo: errorName.bottomAnchor,
                                                                    constant: 6),
                                     errorDescription.leadingAnchor.constraint(equalTo: alertCardView.leadingAnchor, constant: 10),
                                     errorDescription.trailingAnchor.constraint(equalTo: alertCardView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([buttonStack.bottomAnchor.constraint(equalTo: alertCardView.bottomAnchor,
                                                                         constant: -16),
                                     buttonStack.centerXAnchor.constraint(equalTo: alertCardView.centerXAnchor)
                                    ])
        
    }
    
}
