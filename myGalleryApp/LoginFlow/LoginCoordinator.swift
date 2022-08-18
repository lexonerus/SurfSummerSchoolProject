//
//  LoginCoordinator.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorType = .login
    var finishDelegate: CoordinatorFinishDelegate?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginPage()
    }
    func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    
}

extension LoginCoordinator: LoginCoordinatorDelegate {
    func showLoginPage() {
        let loginPageScene = ViewFactory.makeLoginPageScene(delegate: self)
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.pushViewController(loginPageScene, animated: true)
    }
    func loginPassed() {
        finish()
    }
}
