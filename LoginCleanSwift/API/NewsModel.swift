//
//  NewsModel.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 07.05.2022.
//

import Foundation

protocol ArticleDataProtocol {
    var title: String? { get }
    var description: String? { get }
    var url: String? { get }
    var urlToImage: String? { get }
    var publishedAt: String? { get }
    var content: String? { get }
}

struct NewsModel: Codable {
    let articles: [Article]
}

struct Article: Codable & ArticleDataProtocol {
    let source: Source
    
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let name: String?
}
