//
//  SavedArticlesCoordinator.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 03.06.2022.
//

import UIKit

protocol BackToProfileCoordinatorProtocol: AnyObject {
    func navigateBackToProfileCoordinator()
}

class SavedArticlesCoordinator: Coodrinator {
    
    unowned let navigationController: UINavigationController
    
    var childCoordinators: [Coodrinator] = []
    weak var delegate: BackToProfileCoordinatorProtocol?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("DEBUG: SavedArticlesCoordinator has been dealocated")
    }
    
    func start(_ savedArticles: [ArticleModelProtocol]) {
        let savedArticlesVC = SavedNewsTableViewController()
        savedArticlesVC.savedCoordinator = self
        savedArticlesVC.savedArticles = savedArticles
        navigationController.pushViewController(savedArticlesVC, animated: true)
    }
    
}

extension SavedArticlesCoordinator: SavedNewsTableVCCoordinatorDelegate {
    func navigateBackToProfileCoordinator() {
        print("DEBUG: SavedArticlesCoordinator navigateBackToProfileCoordinator method")
        delegate?.navigateBackToProfileCoordinator()
    }
    
    func showWebPage(_ urlString: String) {
        let webVC = WebViewController()
        webVC.loadWebPage(urlString)
        navigationController.pushViewController(webVC, animated: true)
    }
}
