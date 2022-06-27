//
//  NewsCell.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 06.05.2022.
//

import UIKit

protocol SavedNewsContainesDeleteButton: AnyObject {
    func deleteButtonTapped(_ cell: UITableViewCell)
}

final class NewsCell: UITableViewCell {
    
    static let identifier = String(describing: NewsCell.self)
    weak var delegate: SavedNewsContainesDeleteButton?
    
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        return view
    }()
    
    let newsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "mickey_mouse")
        iv.layer.cornerRadius = 18
        iv.layer.cornerCurve = .continuous
        iv.clipsToBounds = true
        return iv
    }()
    
    let newsTitleLabel: UILabel = {
        let label = UILabel()
        let attributedStr = NSAttributedString(string: "Jack Dorsey Thinks Musk Offers Twitter Needed “Cover”", attributes: [.font : UIFont.boldSystemFont(ofSize: 18)])
        label.attributedText = attributedStr
        label.numberOfLines = 2
        return label
    }()
    
    let newsDescriptionView: DescriptionView = {
        let view = DescriptionView()
        return view
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "chevron.forward")
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellDeleteButtonTapped))
        iv.addGestureRecognizer(gestureRecognizer)
        return iv
    }()
    
    private lazy var cellStack: UIStackView = {
        let textStack = UIStackView(arrangedSubviews: [newsTitleLabel, newsDescriptionView])
        textStack.axis = .vertical
        textStack.spacing = 2
        newsTitleLabel.setContentHuggingPriority(.required, for: .vertical)
        newsDescriptionView.setContentHuggingPriority(.required, for: .vertical)
        
        let stack = UIStackView(arrangedSubviews: [newsImageView, textStack, chevronImageView])
        stack.axis = .horizontal
        stack.spacing = 5
        newsImageView.setContentHuggingPriority(.required, for: .vertical)
        textStack.setContentHuggingPriority(.required, for: .vertical)
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with articleModel: ArticleModelProtocol, _ isDeleteModeActive: Bool? = nil) {
        newsImageView.image = UIImage(data: articleModel.imageData)
        newsTitleLabel.text = articleModel.title
        newsDescriptionView.descriptionLabel.text = articleModel.description
        if articleModel.isSaved {
            chevronImageView.image = UIImage(systemName: "star.fill")
            chevronImageView.tintColor = .systemOrange
        } else {
            chevronImageView.image = UIImage(systemName: "chevron.forward")
            chevronImageView.tintColor = .systemBlue
        }
        
        setAppearance(isDeleteModeActive)
    }
    
    @objc func cellDeleteButtonTapped() {
        delegate?.deleteButtonTapped(self)
    }
    
    private func setViews() {
        selectionStyle = .none
        contentView.addSubViewsAndTamicOff([cardView])
        cardView.addSubViewsAndTamicOff([cellStack])
    }
    
    private func setAppearance(_ style: Bool?) {
        guard let style = style else { return }
        if style {
            chevronImageView.image = UIImage(systemName: "minus.circle.fill")
            chevronImageView.tintColor = .systemRed
            chevronImageView.isUserInteractionEnabled = true
        } else {
            chevronImageView.image = UIImage(systemName: "chevron.forward")
            chevronImageView.tintColor = .systemBlue
            chevronImageView.isUserInteractionEnabled = false
        }
    }
    
    private func setConstrains() {
        
        NSLayoutConstraint.activate([cardView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                                     cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                                     cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                                     cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)])
        
        NSLayoutConstraint.activate([newsImageView.heightAnchor.constraint(equalToConstant: 110),
                                     newsImageView.widthAnchor.constraint(equalToConstant: 110),
                                     newsImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
                                     newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.topAnchor),
                                     newsDescriptionView.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor),
                                     chevronImageView.heightAnchor.constraint(equalToConstant: 20),
                                     chevronImageView.widthAnchor.constraint(equalToConstant: 20),
                                     chevronImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5)])
        
        NSLayoutConstraint.activate([cellStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5),
                                     cellStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                                     cellStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                                     cellStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5)])
    }
    
}
