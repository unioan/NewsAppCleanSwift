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
    private static let link = "https://newsapi.org/v2/top-headlines?country=gb&page="
    private static var pageNumber = 0
    private static let apiKey = "&apiKey=9497dbb41ea348d7932167d98fbd4c9b"
    // API keys: 9497dbb41ea348d7932167d98fbd4c9b 3e3d22e0bfc946688a532dc76535414b
    
    private static func fetchImage(with urlToImage: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlToImage) else { return }
        session.dataTask(with: url) { data, _ , _ in
            guard let imageData = data else { return }
            completion(imageData)
        }.resume()
    }
    
    private static func fetchTopNewsModels(compleation: @escaping ([Article]) -> Void) {
        pageNumber += 1
        guard let url = URL(string: link + String(pageNumber) + apiKey) else { return }
        session.dataTask(with: url) { data, _ , _ in
            guard let data = data,
                  let newsModel = try? decoder.decode(NewsModel.self, from: data) else { return }
            let newsModelsHasImages = newsModel.articles.filter {
                if $0.urlToImage != nil && $0.description != nil {
                    return true
                }
                return false
            }
            
            compleation(newsModelsHasImages)
        }.resume()
        
    }
    
    static func fetchTopNews(compleation: @escaping (Result<ProfileModel.ArticleModel, FetchError>) -> Void) {
        fetchTopNewsModels { articles in
            print("DEBUG: articles are comming \(articles)")
            guard articles.count > 0 else {
                DispatchQueue.main.async {
                    compleation(.failure(.NoTopNewsLeft))
                }
                return
            }
            articles.forEach { article in
                fetchImage(with: article.urlToImage!) { imageData in
                    DispatchQueue.main.async {
                        compleation(.success(ProfileModel.ArticleModel(article: article, imageData: imageData)))
                    }
                }
            }
        }
    }
    
    static func resetNewsService() {
        pageNumber = 0
    }
    
}
