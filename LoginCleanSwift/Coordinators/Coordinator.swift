//
//  Coordinator.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 07.04.2022.
//

import UIKit

@objc protocol Coodrinator {
    var childCoordinators: [Coodrinator] { get set }
    init(navigationController: UINavigationController)
    @objc optional func start()
}


