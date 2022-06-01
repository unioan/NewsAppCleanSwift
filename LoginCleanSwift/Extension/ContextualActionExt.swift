//
//  ContextualActionExt.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 31.05.2022.
//

import UIKit

extension UIContextualAction {
    
    static func createTrailingSwipeButton(_ isSaved: Bool, completion: @escaping () -> ()) -> UIContextualAction {
        var tralingSwipeButton: UIContextualAction
        
        if isSaved {
            tralingSwipeButton = UIContextualAction(style: .normal, title: "Remove from saved") { action, view, completionHandler in
                completion()
                completionHandler(true)
            }
            tralingSwipeButton.image = UIImage(systemName: "trash.slash.fill")?.withTintColor(.white)
            tralingSwipeButton.backgroundColor = .systemRed
            
        } else {
            tralingSwipeButton = UIContextualAction(style: .normal, title: "Save") { action, view, completionHandler in
                completion()
                completionHandler(true)
            }
            tralingSwipeButton.image = UIImage(systemName: "square.and.arrow.down")?.withTintColor(.white)
            tralingSwipeButton.backgroundColor = .systemYellow
        }
        return tralingSwipeButton
    }
    
}
