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
}

class ProfilePresenter: ProfilePresentationLogic {
    
    var viewController: ProfileDisplayLogic?
    
    func configureArticleModel(_ article: ProfileModel.ArticleDataTransfer.Response) {
        viewController?.displayArticles(ProfileModel.ArticleDataTransfer.ViewModel(articleModel: article.articleModel))
    }
    
    func noMoreNewsLeft() {
        print("DEBUG fetchTopNews ERROR case in ProfilePresenter")
        viewController?.noMoreNewsLeft()
    }
    
}
