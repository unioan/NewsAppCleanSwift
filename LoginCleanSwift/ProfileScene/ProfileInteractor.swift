//
//  ProfileInteractor.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import Foundation

protocol ProfileBusinessLogic {
    func fetchTopNews()
}

class ProfileInteractor: ProfileBusinessLogic {
    
    var presentor: ProfilePresentationLogic?
    
    func fetchTopNews() {
        NewsService.fetchTopNews { result in
            switch result {
            case .success(let articleModel):
                self.presentor?.configureArticleModel(ProfileModel.ArticleDataTransfer.Response(articleModel: articleModel))
            case .failure(let error):
                print("DEBUG fetchTopNews ERROR case in ProfileInteractor")
                self.presentor?.noMoreNewsLeft()
            }
        }
    }
    
    
}
