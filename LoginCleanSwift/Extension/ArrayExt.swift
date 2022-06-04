//
//  ArrayExt.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 03.06.2022.
//

import Foundation

extension Array where Element == ArticleModelProtocol {
    func markAsSaved(in articles: inout [ArticleModelProtocol]) {
        for (index, article) in articles.enumerated() {
            let match = self.contains { $0.title == article.title }
            if match {
                articles[index].isSaved = true
            } else {
                articles[index].isSaved = false
            }
        }
    }
}
