//
//  CoordinatorDelegate.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import Foundation
import UIKit

protocol CoordinatorDelegate: AnyObject {
    func showDetails(navigation: UINavigationController, item: Picture)
    func showSearch(navigation: UINavigationController)
    func showFavorite(navigation: UINavigationController)
}
