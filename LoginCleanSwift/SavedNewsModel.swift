//
//  SavedNewsModel.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 28.05.2022.
//

import Foundation

protocol SaveArticleProtocol: Codable {
    var login: String { get }
}

struct SavedNewsModel: Codable {
    var login: String
    var article: ProfileModel.ArticleModel
    
    init(login: String, articleModel: ProfileModel.ArticleModel) {
        self.login = login
        self.article = articleModel
    }
    
}
