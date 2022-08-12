//
//  AppCoordinator.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 12.08.2022.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {

    // MARK: Properties
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorType = .app
    
    // MARK: Initializers
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Methods
    func start() {
        showMainFlow()
    }
}

private extension AppCoordinator {
    func showLoginFlow() {
        print("Starting login flow")
    }
    func showMainFlow() {
        print("Starting main flow")
        let tabCoordinator = TabCoordinator(navigationController)
        childCoordinators.append(tabCoordinator)
        tabCoordinator.start()
    }
}
