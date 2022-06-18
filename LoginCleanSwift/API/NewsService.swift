//
//  NewsService.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.05.2022.
//

import Foundation

enum FetchError: Error {
    case NoTopNewsLeft
}

struct NewsService {
    private static let session = URLSession.shared
    private static let decoder = JSONDecoder()
    
    static var query: String = ""
    static var isSearchingMode = false
    
    private static var link: String {
        if isSearchingMode { return "https://newsapi.org/v2/everything?sortBy=relevancy&page=" }
        else { return "https://newsapi.org/v2/top-headlines?country=gb&page=" }
    }
    private static var pageNumber = 0
    private static let apiKey = "&apiKey=fa2130cfbf954c5f888fd55eb8f7b0c9"
    // API keys: 9497dbb41ea348d7932167d98fbd4c9b 3e3d22e0bfc946688a532dc76535414b fa2130cfbf954c5f888fd55eb8f7b0c9
    
    static var searchArticlesCategory: SearchArticlesCategoryType = .general {
        didSet { if oldValue != searchArticlesCategory { pageNumber = 0 } }
    }
    
    static func fetchNews(with query: String? = nil,
                          for category: SearchArticlesCategoryType? = nil,
                          compleation: @escaping (Result<ProfileModel.ArticleModel, FetchError>) -> Void) {
        configureSearchingMode(query, for: category)
        print("DEBUG:: NewsService.fetchNews self.query; \(self.query)")
        fetchNewsModels { articles in
            guard articles.count > 0 else {
                DispatchQueue.main.async { compleation(.failure(.NoTopNewsLeft)) }
                return
            }
            articles.forEach { article in
                fetchImage(with: article.urlToImage!) { imageData in
                    DispatchQueue.main.async { compleation(.success(ProfileModel.ArticleModel(article: article, imageData: imageData)))
                    }
                }
            }
        }
    }
    
    private static func fetchNewsModels(compleation: @escaping ([Article]) -> Void) {
        var url: URL!
        if isSearchingMode {
            guard let queryUrl = URL(string: link + String(pageNumber) + "&q=" + query + apiKey) else { return }
            url = queryUrl
        } else {
            guard let categoryUrl = URL(string: link + String(pageNumber) + searchArticlesCategory.apiCategoryRequest + apiKey) else { return }
            url = categoryUrl
        }
        print("DEBUG:: NewsService.fetchNews pageNumber: \(pageNumber)")
        print("DEBUG:: \(url)")
        
        session.dataTask(with: url) { data, _ , error in
            guard let data = data,
                  let newsModel = try? decoder.decode(NewsModel.self, from: data) else { return }
            let newsModelsHasImages = newsModel.articles.filter {
                if $0.urlToImage != nil && $0.description != nil { return true }
                return false
            }
            compleation(newsModelsHasImages)
        }.resume()
    }
    
    // ===========================================================
    
    private static func configureSearchingMode(_ query: String?, for category: SearchArticlesCategoryType?) {
        if let query = query {
            isSearchingMode = true
            pageNumber += 1
            self.query = ""
            self.query = query
        }
        if let category = category {
            isSearchingMode = false
            searchArticlesCategory = category
            pageNumber += 1
        }
    }
    
    private static func fetchImage(with urlToImage: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlToImage) else { return }
        session.dataTask(with: url) { data, _ , _ in
            guard let imageData = data else { return }
            completion(imageData)
        }.resume()
    }
    
    static func resetPageCounter() {
        pageNumber = 0
    }
    
}
