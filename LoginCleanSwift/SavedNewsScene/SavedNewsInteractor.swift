//
//  SavedNewsInteractor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 13.06.2022.
//

import Foundation

protocol SavedNewsBusinessLogic {
    func setUpViews(_ isDeleteModeActive: Bool)
    func removeArticle(_ article: ArticleModelProtocol, at index: Int)
}

class SavedNewsInteractor: SavedNewsBusinessLogic {

    var presentor: SavedNewsPresentationLogic?
    
    func setUpViews(_ isDeleteModeActive: Bool) {
        presentor?.setUpViews(isDeleteModeActive)
    }
    
    func removeArticle(_ article: ArticleModelProtocol, at index: Int) {
        NewsPersistanceManager.shared.removeArticleFromSaved(article)
        presentor?.removeArticleFromeSavedArray(at: index)
    }

}
