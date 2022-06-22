//
//  SavedNewsModel.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 14.06.2022.
//

import Foundation

struct SavedNewsAdapter {
    
    // MARK: - Properties
    private var savedArticles: [ArticleModelProtocol]
    var savedArticlesDict = [Int: [ArticleModelProtocol]]()
    
    var numberOfSections: Int {
        return savedArticlesDict.keys.count
    }
    
    // MARK: - LifeCycle
    init(savedArticles: [ArticleModelProtocol]) {
        self.savedArticles = savedArticles
        self.savedArticles.sort { $0.dateOfSave! > $1.dateOfSave! }
        initializeDictionary()
    }
    
    // MARK: - Methods
    func numberOfArticles(in section: Int) -> Int {
        guard let articlesCountInSection = articlesForSection(section)?.count else { fatalError() }
        return articlesCountInSection
    }
    // works perfectly fine
    func getDictKeyForSection(_ section: Int) -> Int {
        let sortedKeys = savedArticlesDict.keys.sorted { $0 < $1 }
        let key = sortedKeys[section]
        return key
    }
    // works perfectly fine
    func articlesForSection(_ section: Int) -> [ArticleModelProtocol]? {
        var array: [ArticleModelProtocol]?
        let key = getDictKeyForSection(section)
        array = savedArticlesDict[key]
        return array
    }
    
    func sectionTitle(for section: Int) -> String {
        var title: String = ""
        let sortedKeys = savedArticlesDict.keys.sorted { $0 < $1 }
        
        for (index, key) in sortedKeys.enumerated() {
            if index == section {
                title = determineTitle(for: key)
            }
        }
        return title
    }
    // Needs testing
    func getSavedArticle(for indexPath: IndexPath) -> ArticleModelProtocol {
        guard let articlesFromSection = articlesForSection(indexPath.section) else { fatalError() }
        return articlesFromSection[indexPath.row]
    }
    
    // To be deleted after getSavedArticle is tested / UPD: Waits to be deleted
//    func savedArticle(for indexPath: IndexPath) -> ArticleModelProtocol {
//        guard let articlesFromSection = articlesForSection(indexPath.section) else { fatalError() }
//        let articleFromSection = savedArticles.first { $0.title == articlesFromSection[indexPath.row].title }
//        return articleFromSection!
//    }
    
    mutating func deleteFromSavedNews(_ article: ArticleModelProtocol, at indexPath: IndexPath) {
        guard var articles = articlesForSection(indexPath.section) else { return }
        let key = getDictKeyForSection(indexPath.section)
        if articles.count > 1 {
            articles.remove(at: indexPath.row)
            savedArticlesDict.updateValue(articles, forKey: key)
        } else {
            savedArticlesDict.removeValue(forKey: key)
        }
    }
    
    // MARK: - Internal Methods
    private func determineTitle(for days: Int) -> String {
        let determinedTitle: String
        if days == 0 {
            determinedTitle = "Today"
        } else if days == 1 {
            determinedTitle = "Yesterday"
        } else {
            determinedTitle = "\(days) days ago"
        }
        return determinedTitle
    }
    
    
    // Call upon initializaation
    private mutating func initializeDictionary() {
        let callendar = Calendar.current
        let toDate = callendar.startOfDay(for: Date())
        
        savedArticles.forEach { article in
            let fromDate = callendar.startOfDay(for: article.dateOfSave!)
            guard let daysDifference = callendar.dateComponents([.day], from: fromDate, to: toDate).day else { return }
            
            if var oldValue = savedArticlesDict.removeValue(forKey: daysDifference) {
                oldValue.append(article)
                savedArticlesDict.updateValue(oldValue, forKey: daysDifference)
            } else {
                savedArticlesDict.updateValue([article], forKey: daysDifference)
            }
        }
    }
}
