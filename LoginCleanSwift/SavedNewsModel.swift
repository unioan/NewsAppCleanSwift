//
//  SavedNewsModel.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 28.05.2022.
//

import Foundation

protocol SaveArticleProtocol: ArticleDataProtocol {
    var login: String { get }
}

struct SavedNewsModel: Codable & SaveArticleProtocol {
    var login: String
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    init(login: String, articleModel: ArticleDataProtocol) {
        self.login = login
        self.title = articleModel.title
        self.description = articleModel.description
        self.url = articleModel.url
        self.urlToImage = articleModel.urlToImage
        self.publishedAt = articleModel.publishedAt
        self.content = articleModel.content
    }
    
}
