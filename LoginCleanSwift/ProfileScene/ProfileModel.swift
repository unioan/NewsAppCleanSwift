//
//  ProfileModel.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import Foundation

enum ProfileModel {
    
    enum ArticleDataTransfer {
        struct Request {}
        
        struct Response {
            let articleModel: ProfileModel.ArticleModel
        }
        
        struct ViewModel {
            let articleModel: ProfileModel.ArticleModel
        }
    }
    
    struct ArticleModel {
        let title: String
        let description: String
        let urlToNewsSource: String
        let imageData: Data
        
        init() {
            title = ""
            description = ""
            urlToNewsSource = ""
            imageData = Data()
        }
        
        init(article: Article, imageData: Data) {
            title = article.title ?? ""
            description = article.description ?? ""
            urlToNewsSource = article.url ?? ""
            self.imageData = imageData
        }
    }
    
}
