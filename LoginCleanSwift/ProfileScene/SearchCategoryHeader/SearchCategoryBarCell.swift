//
//  SearchCategoryBarCell.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 05.06.2022.
//

import UIKit

class SearchCategoryBarCell: UICollectionViewCell {
    
    static let identifier = String(describing: SearchCategoryBarCell.self)
    
    let backView: UIView = {
        let sb = UIView()
        sb.backgroundColor = .white
        sb.clipsToBounds = true
        return sb
    }()
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Global search"
        sb.showsCancelButton = true
        return sb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubViewsAndTamicOff([backView])
        backView.addSubViewsAndTamicOff([searchBar])
    }
    
    private func setupConstrints() {
        NSLayoutConstraint.activate([backView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                                     backView.leftAnchor.constraint(equalTo: leftAnchor),
                                     backView.rightAnchor.constraint(equalTo: rightAnchor)])
        
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: backView.topAnchor, constant: -10),
                                     searchBar.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0),
                                     searchBar.leftAnchor.constraint(equalTo: backView.leftAnchor),
                                     searchBar.rightAnchor.constraint(equalTo: backView.rightAnchor)])
    }
    
}
