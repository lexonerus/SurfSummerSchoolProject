//
//  TabBarModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import Foundation
import UIKit

enum TabBarModel {
    case main
    case favorite
    case profile
    
    var title: String {
        switch self {
        case .main:
            return "Главная"
        case .favorite:
            return "Избранное"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .main:
            return UIImage(named: "item-home")
        case .favorite:
            return UIImage(named: "item-favorite")
        case .profile:
            return UIImage(named: "item-profile")
        }
    }
    
    var selectedImage: UIImage? {
        return image
    }
    
}
