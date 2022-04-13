//
//  UIViewExt.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 07.04.2022.
//

import UIKit

extension UIView {
    
    func addSubViewsAndTamicOff(_ views: [UIView]) {
        views.forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
