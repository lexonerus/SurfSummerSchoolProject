//
//  Coordinator.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 12.08.2022.
//

import UIKit

protocol Coordinator {
    
    // MARK: Properties
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    var type: CoordinatorType { get }
    
    init(_ navigationController: UINavigationController)
    
    // MARK: Methods
    func start()
}
