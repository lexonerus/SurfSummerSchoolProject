//
//  FavoriteModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 07.08.2022.
//

import Foundation
import UIKit.UIImage

final class FavoriteModel {
    
    // MARK: Events
    // Раpзобраться как работает !!!
    var didItemsUpdated: (() -> Void)?
    
    // MARK: Properties
    var items = [FavoriteItemModel]() {
        didSet {
            didItemsUpdated?()
        }
    }
    
    // MARK: Methods
    func getFavoritePosts() {
        items = Array(repeating: FavoriteItemModel.createDefault(), count: 5)
    }
}
