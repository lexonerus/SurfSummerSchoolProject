//
//  TabBarConfig.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import Foundation
import UIKit

class TabBarConfig {
    
    private let allTab: [TabBarModel] = [.main, .favorite, .profile]
    
    func configure() -> UITabBarController {
        return getTabBarController()
    }
}

private extension TabBarConfig {
    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.07681330293, green: 0.07681333274, blue: 0.07681330293, alpha: 1)
        tabBarController.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getTabBarControllers()
        return tabBarController
    }

    func getTabBarControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        allTab.forEach { tab in
            let controller = getCurrentViewController(tab: tab)
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = tabBarItem
            viewControllers.append(controller)
        }
        return viewControllers
    }
                        
    func getCurrentViewController(tab: TabBarModel) -> UIViewController {
        switch tab {
        case .main:
            return setupNaviController(rootViewController: MainViewController())
        case .favorite:
            return setupNaviController(rootViewController: FavoriteViewController())
        case .profile:
            return setupNaviController(rootViewController: ProfileViewController())
        }
    }
    
    func setupNaviController(rootViewController: UIViewController) -> UIViewController {
        let navigationController = UINavigationController.init(rootViewController: rootViewController)
        navigationController.navigationBar.tintColor = #colorLiteral(red: 0.07681330293, green: 0.07681333274, blue: 0.07681330293, alpha: 1)
        return navigationController
    }

}
