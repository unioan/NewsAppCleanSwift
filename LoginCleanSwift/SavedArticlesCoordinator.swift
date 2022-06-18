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
    
    func start(_ savedArticles: [ArticleModelProtocol]) {
        navigationController.navigationBar.prefersLargeTitles = true
        
        let savedArticlesVC = SavedNewsTableViewController()
        let interactor = SavedNewsInteractor()
        let presentor = SavedNewsPresentor()
        presentor.viewController = savedArticlesVC
        interactor.presentor = presentor
        savedArticlesVC.interactor = interactor
        
        savedArticlesVC.savedCoordinator = self
        // Remove savedArticles
        savedArticlesVC.savedArticles = savedArticles
        // Initialize SavedNewsModel with array of savedArticles
        navigationController.pushViewController(savedArticlesVC, animated: true)
    }
    
}

extension SavedArticlesCoordinator: SavedNewsTableVCCoordinatorDelegate {
    func navigateBackToProfileCoordinator() {
        delegate?.navigateBackToProfileCoordinator()
    }
    
    func showWebPage(_ urlString: String) {
        let webVC = WebViewController()
        webVC.loadWebPage(urlString)
        navigationController.pushViewController(webVC, animated: true)
    }
}
