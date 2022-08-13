//
//  Coordinator.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 12.08.2022.
//

import Foundation
import UIKit

protocol TabBarCoordinator: Coordinator {
    
    // MARK: Properties
    var tabBarController: UITabBarController? { get set }
    
}
