//
//  ContextualActionExt.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 31.05.2022.
//

import UIKit

enum ActionType {
    case save, delete
}

extension UIContextualAction {
    
    static func createTrailingSwipeButton(_ article: ArticleModelProtocol, completion: @escaping (ActionType) -> ()) -> UIContextualAction {
        var tralingSwipeButton: UIContextualAction
        
        if article.isSaved {
            tralingSwipeButton = UIContextualAction(style: .normal, title: "Remove from saved") { action, view, completionHandler in
                completion(.delete)
                completionHandler(true)
            }
            tralingSwipeButton.image = UIImage(systemName: "trash.slash.fill")?.withTintColor(.white)
            tralingSwipeButton.backgroundColor = .systemRed
            
        } else {
            tralingSwipeButton = UIContextualAction(style: .normal, title: "Save") { action, view, completionHandler in
                completion(.save)
                completionHandler(true)
            }
            tralingSwipeButton.image = UIImage(systemName: "square.and.arrow.down")?.withTintColor(.white)
            tralingSwipeButton.backgroundColor = .systemYellow
        }
        return tralingSwipeButton
    }
    
}
