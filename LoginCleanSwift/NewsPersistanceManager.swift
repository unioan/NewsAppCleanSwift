//
//  NewsPersistanceManager.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 28.05.2022.
//

import Foundation

class NewsPersistanceManager {
    
    static let shared = NewsPersistanceManager()
    private let manager = FileManager.default
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var login: String { PasswordManager.shared.userLogin }
    private var savedArticlesDirectory: URL {
        let url = FileManager.documentDirectoryURL.appendingPathComponent("savedArticles\(login)")
        try? manager.createDirectory(at: url, withIntermediateDirectories: false, attributes: [:])
        return url
    }
    
    private init() {}
    
    private func createSavedArticleFile(_ name: String, articleData: Data) {
        let fileURL = savedArticlesDirectory.appendingPathComponent("\(name).json")
        manager.createFile(atPath: fileURL.path, contents: articleData, attributes: [FileAttributeKey.creationDate: Date()])
    }
    
    func saveArticle(articleModel: ArticleModelProtocol) {
        guard let articleModel = articleModel as? ProfileModel.ArticleModel,
              let articleData = try? encoder.encode(articleModel) else { return }
        let fileName = articleModel.title.replacingOccurrences(of: " ", with: "")
        createSavedArticleFile(fileName, articleData: articleData)
    }
    
    func getSavedArticles(compleation: ([ArticleModelProtocol]) -> ()) {
        print("DEBUG::: NewsPersistanceManager - authenticated user \(login)")
        guard let articlesNames = try? manager.contentsOfDirectory(atPath: savedArticlesDirectory.path) else { return }
        let urlsToArticles = articlesNames.map { [weak self] articleName in
            self?.savedArticlesDirectory.appendingPathComponent(articleName)
        }
        let articlesData = urlsToArticles.map { try? Data(contentsOf: $0!) }
        let articleOptionalModels = articlesData.map { [weak self] articleData in
            try? self?.decoder.decode(ProfileModel.ArticleModel.self, from: articleData ?? Data())
        }
        let articles = articleOptionalModels.compactMap { $0 }
        compleation(articles)
    }
    
    func removeArticleFromSaved(_ articleModel: ArticleModelProtocol) {
        let articleName = articleModel.title.replacingOccurrences(of: " ", with: "")
        let fileURL = savedArticlesDirectory.appendingPathComponent("\(articleName).json")
        try? manager.removeItem(atPath: fileURL.path)
    }
    
}
