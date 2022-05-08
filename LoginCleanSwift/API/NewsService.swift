//
//  NewsService.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.05.2022.
//

import Foundation

struct NewsService {
    
    private static let session = URLSession.shared
    private static let decoder = JSONDecoder()
    private static let link = "https://newsapi.org/v2/top-headlines?country=gb&"
    private static let apiKey = "apiKey=3e3d22e0bfc946688a532dc76535414b"
    
    private static func fetchImage(with urlToImage: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlToImage) else { return }
        session.dataTask(with: url) { data, _ , _ in
            guard let imageData = data else { return }
            completion(imageData)
        }.resume()
    }
    
    private static func fetchTopNewsModels(compleation: @escaping ([Article]) -> Void) {
        guard let url = URL(string: link + apiKey) else { return }
        session.dataTask(with: url) { data, _ , _ in
            guard let data = data,
                  let newsModels = try? decoder.decode(NewsModel.self, from: data) else { return }
            let newsModelsHasImages = newsModels.articles.filter {
                if $0.urlToImage != nil && $0.description != nil {
                    return true
                }
                return false
            }
            compleation(newsModelsHasImages)
        }.resume()
        
    }
    
    static func fetchTopNews(compleation: @escaping (Result<ProfileModel.ArticleModel, Error>) -> Void) {
        fetchTopNewsModels { articles in
            articles.forEach { article in
                fetchImage(with: article.urlToImage!) { imageData in
                    DispatchQueue.main.async {
                        compleation(.success(ProfileModel.ArticleModel(article: article, imageData: imageData)))
                    }
                }
            }
        }
    }
    
    
}
