//
//  TabCoordinator.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 12.08.2022.
//

import Foundation
import UIKit

class TabCoordinator: NSObject, TabBarCoordinator {

    
    // MARK: Properties
    var tabBarController: UITabBarController
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = TabBarConfig().configure()
    }
    
    // MAKR: Methods
    func start() {
        navigationController.viewControllers = [tabBarController]
    }
   
}
