//
//  ErrorCell.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 10.06.2022.
//

import UIKit

final class ErrorCell: UITableViewCell {
    
    static let identifier = String(describing: ErrorCell.self)
    
    let errorImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "wifi.exclamationmark")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    // 18
    let errorTitleLable: UILabel = {
        let label = UILabel()
        let attributedStr = NSAttributedString(string: "No internet connection", attributes: [.font : UIFont.boldSystemFont(ofSize: 22)])
        label.attributedText = attributedStr
        label.numberOfLines = 2
        return label
    }()
    // 16
    let errorDescriptionLabel: UILabel = {
        let label = UILabel()
        let attributedStr = NSAttributedString(string: "Please, check your internet connection",
                                               attributes: [.font : UIFont.systemFont(ofSize: 20)])
        label.attributedText = attributedStr
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let errorBackground: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var cellStack: UIStackView = {
        let firstTextStack = UIStackView(arrangedSubviews: [errorTitleLable, errorDescriptionLabel])
        firstTextStack.axis = .vertical
        firstTextStack.alignment = .leading
        firstTextStack.distribution = .equalCentering
        firstTextStack.spacing = 5
        
        let secondTextStack = UIStackView(arrangedSubviews: [firstTextStack])
        secondTextStack.alignment = .center
        
        let fullStack = UIStackView(arrangedSubviews: [errorImageView, secondTextStack])
        fullStack.axis = .horizontal
        firstTextStack.alignment = .leading
        fullStack.spacing = 8
        return fullStack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubViewsAndTamicOff([cellStack])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([errorImageView.heightAnchor.constraint(equalToConstant: 110),
                                     errorImageView.widthAnchor.constraint(equalToConstant: 110)])
        
        NSLayoutConstraint.activate([errorDescriptionLabel.trailingAnchor.constraint(equalTo: cellStack.trailingAnchor)])
        
        NSLayoutConstraint.activate([cellStack.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     cellStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     cellStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)])
        
    
        
//        NSLayoutConstraint.activate([errorDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//                                     errorTitleLable.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8)])
    }
    
}

