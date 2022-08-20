//
//  LoginCoordinator.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    // MARK: Properties
    var navigationController:   UINavigationController
    var childCoordinators:      [Coordinator] = [Coordinator]()
    var type:                   CoordinatorType = .login
    var finishDelegate:         CoordinatorFinishDelegate?
    
    // MARK: Initializers
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Methods
    func start() {
        showLoginPage()
    }
    func finish() {
        DispatchQueue.main.async {
            self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
        }
        
    }
    
    // MARK: Deinitializers
    deinit {
        print("Login coordinator deinit")
    }
}

// MARK: Coordinator delegate
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
