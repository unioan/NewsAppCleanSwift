//
//  ProfilePresenter.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 09.04.2022.
//

import UIKit

enum HeaderType {
    case hidden, shown, aboutToHide
}

protocol ProfilePresentationLogic {
    func configureArticleModel(_ article: ProfileModel.ArticleDataTransfer.Response)
    func noMoreNewsLeft()
    func displaySaved()
    func displaySavedAfterRemovingArticle(_ index: Int)
    func setUpNavigationBarButtons()
    func animateNewsTableViewHeader(_ scrollPosition: Double)
}

class ProfilePresenter: ProfilePresentationLogic {
    
    var viewController: ProfileDisplayLogic?
    var headerType: HeaderType = .hidden
    
    func setUpNavigationBarButtons() {
        guard let profileVC = viewController as? ProfileViewController else { return }
        let leftButton = UIBarButtonItem(title: "Log out", style: .plain, target: profileVC, action: #selector(profileVC.logOutButtonTapped))
        profileVC.navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(title: "Saved", style: .plain, target: profileVC, action: #selector(profileVC.savedButtonTapped))
        profileVC.navigationItem.rightBarButtonItem = rightButton
    }
    
    func configureArticleModel(_ article: ProfileModel.ArticleDataTransfer.Response) {
        viewController?.displayArticles(ProfileModel.ArticleDataTransfer.ViewModel(articleModel: article.articleModel))
    }
    
    func noMoreNewsLeft() {
        viewController?.noMoreNewsLeft()
    }
    
    func displaySaved() {
        viewController?.getSavedArticles()
    }
    
    func displaySavedAfterRemovingArticle(_ index: Int) {
        viewController?.removeArticleFromeSavedArray(index)
        viewController?.getSavedArticles()
    }
    
    func animateNewsTableViewHeader(_ scrollPosition: Double) {
        if scrollPosition < -0.1 && headerType == .hidden {
            viewController?.profileView?.newsTableView.contentInset = UIEdgeInsets(top: -(viewController?.profileView?.headerView.bounds.height)!, left: 0, bottom: 0, right: 0)
            headerType = .shown
                               // -40 / -20
        } else if scrollPosition < 0 && headerType == .shown {
            UIView.animate(withDuration: TimeInterval.init(floatLiteral: 0.5), delay: .zero, options: .curveLinear) {
                self.viewController?.profileView?.newsTableView.contentInset = UIEdgeInsets.zero
            } completion: { _ in self.headerType = .aboutToHide }
        } else if scrollPosition < -100 && headerType == .aboutToHide {
            UIView.animate(withDuration: TimeInterval.init(floatLiteral: 0.5), delay: .zero, options: .curveLinear) {
                self.viewController?.profileView?.newsTableView.contentInset = UIEdgeInsets(
                    top: -(self.viewController?.profileView?.headerView.bounds.height)!, left: 0, bottom: 0, right: 0)
            } completion: { _ in self.headerType = .hidden }
        }
    }
    
}
