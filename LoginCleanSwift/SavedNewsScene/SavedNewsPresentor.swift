//
//  SavedNewsPresentor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 13.06.2022.
//

import UIKit

protocol SavedNewsPresentationLogic {
    func setUpViews(_ isDeleteModeActive: Bool)
    func removeArticleFromSavedAdapter(_ article: ArticleModelProtocol, at indexPath: IndexPath)
}

final class SavedNewsPresentor: SavedNewsPresentationLogic {
    
    weak var viewController: SavedNewsDisplayLogic?
    
    func setUpViews(_ isDeleteModeActive: Bool) {
        guard let savedNewsVC = viewController as? SavedNewsTableViewController else { return }
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: savedNewsVC, action: #selector(savedNewsVC.navigateToProfileVC))
        savedNewsVC.navigationItem.leftBarButtonItem = backButton
        
        let deleteButtonImage: UIImage!
        let deleteNewsButton: UIBarButtonItem!
        
        if isDeleteModeActive {
            deleteNewsButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"),
                                               style: .plain,
                                               target: savedNewsVC,
                                               action: #selector(savedNewsVC.deleteNewsButtonTapped))
            deleteNewsButton.tintColor = .systemGreen
        } else {
            deleteButtonImage = UIImage(systemName: "trash.fill")
            deleteNewsButton = UIBarButtonItem(image: deleteButtonImage,
                                               style: .plain,
                                               target: savedNewsVC,
                                               action: #selector(savedNewsVC.deleteNewsButtonTapped))
            deleteNewsButton.tintColor = .systemRed
        }
        
        savedNewsVC.navigationItem.rightBarButtonItem = deleteNewsButton
    }
    
    
    func removeArticleFromSavedAdapter(_ article: ArticleModelProtocol, at indexPath: IndexPath) {
        viewController?.removeArticleFromSavedAdapter(article, at: indexPath)
    }
    
}
