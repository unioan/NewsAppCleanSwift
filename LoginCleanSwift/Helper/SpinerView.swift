//
//  SpinerView.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 08.05.2022.
//

import UIKit

class SpinerView: UIActivityIndicatorView {
    
//    color = UIColor.darkGray
//    hidesWhenStopped = true
    
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
