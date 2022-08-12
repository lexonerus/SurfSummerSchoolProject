//
//  TabBarConfig.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import Foundation
import UIKit

class TabBarConfig {
    // MARK: Properties
    private let allTab: [TabBarPage] = [.main, .favorite, .profile]
    // MARK: Methods
    func configure() -> UITabBarController {
        return getTabBarController()
    }
}

// MARK: Private Methods
private extension TabBarConfig {
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
            return MainViewController()
        case .favorite:
            return FavoriteViewController()
        case .profile:
            return ProfileViewController()
        }
    }

}
