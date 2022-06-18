//
//  ProfileInteractor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import Foundation

protocol ProfileBusinessLogic {
    func setUpNavigationBarButtons()
    func saveArticle(_ article: ArticleModelProtocol)
    func removeArticle(_ article: ArticleModelProtocol?, from savedArticles: [ArticleModelProtocol])
    func animateNewsTableViewHeader(_ scrollPosition: Double)
    func fetchTopNews(for selectedCategory: SearchArticlesCategoryType)
    func fetchNews(with query: String?)
}

class ProfileInteractor: ProfileBusinessLogic {
    
    var presentor: ProfilePresentationLogic?
    
    func setUpNavigationBarButtons() {
        presentor?.setUpNavigationBarButtons()
    }
    
    func fetchTopNews(for selectedCategory: SearchArticlesCategoryType) {
        NewsService.fetchNews(for: selectedCategory) { result in
            switch result {
            case .success(let articleModel):
                self.presentor?.configureArticleModel(ProfileModel.ArticleDataTransfer.Response(articleModel: articleModel))
            case .failure(_):
                self.presentor?.noMoreNewsLeft()
            }
        }
    }
    
    func fetchNews(with query: String?) {
        NewsService.fetchNews(with: query, for: nil) { result in
            switch result {
            case .success(let articleModel):
                self.presentor?.configureArticleModel(ProfileModel.ArticleDataTransfer.Response(articleModel: articleModel))
            case .failure(_):
                self.presentor?.noMoreNewsLeft()
            }
        }
    }
    
    func saveArticle(_ article: ArticleModelProtocol) {
        NewsPersistanceManager.shared.saveArticle(articleModel: article)
        presentor?.displaySaved()
    }
    
    func removeArticle(_ article: ArticleModelProtocol?, from savedArticles: [ArticleModelProtocol]) {
        guard let article = article else { return }
        NewsPersistanceManager.shared.removeArticleFromSaved(article)
        let indexForRemoving = savedArticles.firstIndex { $0.title == article.title }
        guard let index = indexForRemoving else { return }
        presentor?.displaySavedAfterRemovingArticle(index)
    }
    
    func animateNewsTableViewHeader(_ scrollPosition: Double) {
        presentor?.animateNewsTableViewHeader(scrollPosition)
    }
    
}
