//
//  NewsPersistanceManager.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 28.05.2022.
//

import Foundation

struct NewsManager {
    
    static let shared = NewsManager()
    private let login = PasswordManager.shared.userLogin
    private lazy var url = URL(fileURLWithPath: login, relativeTo: FileManager.documentDirectoryURL)
    
    private init() {}
    
    mutating func saveArticle(articleModel: ArticleDataProtocol) {
        guard let articleData = try? JSONEncoder().encode(SavedNewsModel(login: login, articleModel: articleModel)) else { return }
        try? articleData.write(to: url)
    }
    
    mutating func getSavedArticles(compleation: (ArticleDataProtocol) -> ()) {
        guard let savedArticlesData = try? Data(contentsOf: url),
              let savedArticlesModel = try? JSONDecoder().decode(SavedNewsModel.self, from: savedArticlesData)
        else { return }
        compleation(savedArticlesModel)
    }
    
}
