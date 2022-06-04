//
//  ProfileModel.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import Foundation

protocol ArticleModelProtocol: Codable {
    var title: String { get }
    var description: String { get }
    var urlToNewsSource: String { get }
    var imageData: Data { get }
    var isSaved: Bool { get set }
    var dateOfSave: Date? { get set }
}

enum ProfileModel {
    
    enum ArticleDataTransfer {
        struct Request {}
        
        struct Response {
            let articleModel: ArticleModelProtocol
        }
        
        struct ViewModel {
            let articleModel: ArticleModelProtocol
        }
    }
    
    struct ArticleModel: ArticleModelProtocol {
        let title: String
        let description: String
        let urlToNewsSource: String
        let imageData: Data
        var isSaved: Bool = false
        var dateOfSave: Date?
        
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
