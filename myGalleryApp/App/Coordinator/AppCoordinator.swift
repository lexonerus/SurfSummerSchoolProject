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
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    // MARK: Initializers
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
        finishDelegate = self
    }
    
    // MARK: Methods
    func start() {
        showMainFlow()
    }
    func start(isLoggedIn: Bool) {
        isLoggedIn ? showMainFlow() : showLoginFlow()
    }
    func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    deinit {
        print("App coordinator deinit")
    }
}

// MARK: Private methods
private extension AppCoordinator {
    func showLoginFlow() {
        print("Starting login flow")
        let loginCoordinator = LoginCoordinator(navigationController)
        loginCoordinator.finishDelegate = self
        self.childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    func showMainFlow() {
        print("Starting main flow")
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        childCoordinators.append(tabCoordinator)
        tabCoordinator.start()
    }
}

// MARK: CoordinatorFinishDelegate
extension AppCoordinator: CoordinatorFinishDelegate {

    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .app:
            navigationController.viewControllers.removeAll()
        case .tab:
            navigationController.viewControllers.removeAll()
            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()
            navigationController.setNavigationBarHidden(true, animated: false)
            showMainFlow()
        }
    }
}
