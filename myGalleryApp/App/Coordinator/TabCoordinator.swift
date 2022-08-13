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
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorType { .tab }
    private let allTab: [TabBarPage] = [.main, .favorite, .profile]

    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MAKR: Methods
    func configure() -> UITabBarController {
        return getTabBarController()
    }
    
    func start() {
        self.tabBarController = configure()
        navigationController.viewControllers = [tabBarController!]
        showMainTab()
    }
    
    func showDetailsScene(navigation: UINavigationController, item: Picture) {
        let detailsScene = DetailTableViewController()
        detailsScene.model = item
        navigation.pushViewController(detailsScene, animated: true)
    }
    
    func showMainTab() {
        tabBarController?.selectedIndex = 0
    }
    
    func showFavoriteTab() {
        tabBarController?.selectedIndex = 1
    }
    
    func showProfileTab() {
        tabBarController?.selectedIndex = 2
    }

   
}

extension TabCoordinator: MainViewPresenterDelegate {
    func showDetails(navigation: UINavigationController, item: Picture) {
        showDetailsScene(navigation: navigation, item: item)
    }
}

// MARK: Private Methods
private extension TabCoordinator {
    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor               = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBarController.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tabBarController.tabBar.barTintColor            = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBarController.tabBar.backgroundColor         = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBarController.viewControllers                = getTabBarControllers()
        
        return tabBarController
    }

    func getTabBarControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        allTab.forEach { tab in

            let controller = getCurrentViewController(tab: tab)
            let navigationView = UINavigationController(rootViewController: controller)
            navigationView.navigationBar.tintColor = .black
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = tabBarItem
            viewControllers.append(navigationView)
        }
        return viewControllers
    }
                        
    func getCurrentViewController(tab: TabBarPage) -> UIViewController {
        switch tab {
        case .main:
            return TabViewFactory.makeMainScene(delegate: self)
        case .favorite:
            return FavoriteViewController()
        case .profile:
            return ProfileViewController()
        }
    }

}

