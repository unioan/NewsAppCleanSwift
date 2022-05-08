//
//  DescriptionView.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 08.05.2022.
//

import UIKit

class DescriptionView: UIView {
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        let attributedStr = NSAttributedString(string: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", attributes: [.font : UIFont.systemFont(ofSize: 16)])
        label.attributedText = attributedStr
        label.numberOfLines = 4
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubViewsAndTamicOff([descriptionLabel])
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
                                     descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    
}
