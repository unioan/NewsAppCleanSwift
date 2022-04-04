//
//  TFLeftViewExt.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 03.04.2022.
//

import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20)) // Create ImageView and set its image
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30)) // Create View
        iconContainerView.addSubview(iconView) // add ImageView as a subview
        leftView = iconContainerView // Set View as left view
        leftViewMode = .always
    }
}

