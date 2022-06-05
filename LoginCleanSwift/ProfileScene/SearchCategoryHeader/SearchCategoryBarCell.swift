//
//  SearchCategoryBarCell.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 05.06.2022.
//

import UIKit

class SearchCategoryBarCell: UICollectionViewCell {
    
    static let identifier = String(describing: SearchCategoryBarCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
