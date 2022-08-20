//
//  Coordinator.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 12.08.2022.
//

import UIKit

protocol Coordinator {
    
    // MARK: Properties
    var navigationController:   UINavigationController { get set }
    var childCoordinators:      [Coordinator] { get set }
    var finishDelegate:         CoordinatorFinishDelegate? { get set }
    var type:                   CoordinatorType { get }
    
    // MARK: Initializers
    init(_ navigationController: UINavigationController)
    
    // MARK: Methods
    func start()
    func finish()
}

// MARK: Finish coordinator states
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// MARK: Coordinator types
enum CoordinatorType {
    case app
    case tab
    case login
}
