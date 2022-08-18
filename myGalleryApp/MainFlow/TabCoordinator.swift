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
    var finishDelegate: CoordinatorFinishDelegate?
    private let allTab: [TabBarModel] = [.main, .favorite, .profile]

    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MAKR: Methods
    func configure() -> UITabBarController {
        return getTabBarController()
    }
    
    func start() {
        tabBarController = self.configure()
        navigationController.viewControllers = [self.tabBarController!]
        showMainTab()
    }
    func finish() {
        
    }
    
    func showDetailsScene(navigation: UINavigationController, item: Picture) {

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
    
    deinit {
        print("Tab coordinator deinit")
    }

   
}

extension TabCoordinator: TabCoordinatorDelegate {
    func showFavorite(navigation: UINavigationController) {
        let favoriteScene = ViewFactory.makeFavoriteScene(delegate: self)
        navigation.pushViewController(favoriteScene, animated: true)
    }
    
    func showDetails(navigation: UINavigationController, item: Picture) {
        let detailsScene = ViewFactory.makeDetailsScene(delegate: self, item: item)
        navigation.pushViewController(detailsScene, animated: true)
    }
    func showSearch(navigation: UINavigationController) {
        let searchScene = ViewFactory.makeSearchScene(delegate: self)
        navigation.pushViewController(searchScene, animated: true)
    }
}

// MARK: Private Methods
private extension TabCoordinator {
    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor               = AppColors.tintColor
        tabBarController.tabBar.unselectedItemTintColor = AppColors.unselectedItem
        tabBarController.tabBar.barTintColor            = AppColors.tabBarTint
        tabBarController.tabBar.backgroundColor         = AppColors.tabBarBackground
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
                        
    func getCurrentViewController(tab: TabBarModel) -> UIViewController {
        switch tab {
        case .main:
            return ViewFactory.makeMainScene(delegate: self)
        case .favorite:
            return ViewFactory.makeFavoriteScene(delegate: self)
        case .profile:
            return ProfileViewController()
        }
    }

}

