//
//  SearchCategoryHeaderView.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 05.06.2022.
//

import UIKit

enum SearchCategoryHeaderType: Int, CaseIterable {
    case searchCategory, searchBar
}

class SearchCategoryHeaderView: UICollectionView {
    
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 90)
        let collectionViewLayout = Self.createCompositionalLayout()
        self.init(frame: frame, collectionViewLayout: collectionViewLayout)
        
        register(SearchCategoryBarCell.self, forCellWithReuseIdentifier: SearchCategoryBarCell.identifier)
        register(SearchArticlesCategoryCell.self, forCellWithReuseIdentifier: SearchArticlesCategoryCell.identifier)
        
        isScrollEnabled = false
        backgroundColor = .white
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment -> NSCollectionLayoutSection? in
            guard let sectionKind = SearchCategoryHeaderType(rawValue: sectionIndex) else { return nil }
            
            switch sectionKind {
            case .searchCategory:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(100), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 5, leading: 8, bottom: 5, trailing: 10)
                return section
            case .searchBar:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.6)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                return section
            }
        }
       return layout
    }
    
    
}
