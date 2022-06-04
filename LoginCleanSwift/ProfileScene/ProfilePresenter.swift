//
//  ProfilePresenter.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import Foundation

protocol ProfilePresentationLogic {
    func configureArticleModel(_ article: ProfileModel.ArticleDataTransfer.Response)
    func noMoreNewsLeft()
    func displaySaved()
    func displaySavedAfterRemovingArticle(_ index: Int)
    func setUpNavigationBarButtons()
}

class ProfilePresenter: ProfilePresentationLogic {
    
    var viewController: ProfileDisplayLogic?
    
    func setUpNavigationBarButtons() {
        
    }
    
    func configureArticleModel(_ article: ProfileModel.ArticleDataTransfer.Response) {
        viewController?.displayArticles(ProfileModel.ArticleDataTransfer.ViewModel(articleModel: article.articleModel))
    }
    
    func noMoreNewsLeft() {
        viewController?.noMoreNewsLeft()
    }
    
    func displaySaved() {
        viewController?.getSavedArticles()
    }
    
    func displaySavedAfterRemovingArticle(_ index: Int) {
        viewController?.removeArticleFromeSavedArray(index)
        viewController?.getSavedArticles()
    }
    
}
