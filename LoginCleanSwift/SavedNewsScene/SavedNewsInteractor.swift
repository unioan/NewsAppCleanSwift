//
//  SavedNewsInteractor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 13.06.2022.
//

import Foundation

protocol SavedNewsBusinessLogic {
    func setUpViews(_ isDeleteModeActive: Bool)
    func removeArticle(_ article: ArticleModelProtocol, at indexPath: IndexPath)
}

final class SavedNewsInteractor: SavedNewsBusinessLogic {

    var presentor: SavedNewsPresentationLogic?
    
    func setUpViews(_ isDeleteModeActive: Bool) {
        presentor?.setUpViews(isDeleteModeActive)
    }
    
    func removeArticle(_ article: ArticleModelProtocol, at indexPath: IndexPath)  {
        NewsPersistanceManager.shared.removeArticleFromSaved(article)
        // update to delete article from dictionary
        presentor?.removeArticleFromSavedAdapter(article, at: indexPath)
    }

}
