//
//  ProfileInteractor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import Foundation

protocol ProfileBusinessLogic {
    func fetchTopNews()
    func saveArticle(_ article: ArticleModelProtocol)
    func removeArticle(_ article: ArticleModelProtocol?, from savedArticles: [ArticleModelProtocol])
}

class ProfileInteractor: ProfileBusinessLogic {
    
    var presentor: ProfilePresentationLogic?
    
    func fetchTopNews() {
        NewsService.fetchTopNews { result in
            switch result {
            case .success(let articleModel):
                self.presentor?.configureArticleModel(ProfileModel.ArticleDataTransfer.Response(articleModel: articleModel))
                print("DEBUG fetchTopNews worked")
            case .failure(_):
                print("DEBUG fetchTopNews ERROR case in ProfileInteractor")
                self.presentor?.noMoreNewsLeft()
            }
        }
    }
    
    func saveArticle(_ article: ArticleModelProtocol) {
        NewsPersistanceManager.shared.saveArticle(articleModel: article)
        presentor?.displaySaved()
        print("DEBUG saveArticle from ProfileInteractor WORKED!")
    }
    
    func removeArticle(_ article: ArticleModelProtocol?, from savedArticles: [ArticleModelProtocol]) {
        guard let article = article else { return }
        NewsPersistanceManager.shared.removeArticleFromSaved(article)
        let indexForRemoving = savedArticles.firstIndex { $0.title == article.title }
        guard let index = indexForRemoving else { return }
        presentor?.displaySavedAfterRemovingArticle(index)
    }
    
}
