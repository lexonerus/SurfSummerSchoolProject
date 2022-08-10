//
//  FavoriteModelMain.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 09.08.2022.
//

import Foundation
import UIKit.UIImage

class FavoriteModelMain {
    
    // MARK: Events
    var didItemsUpdated: (() -> Void)?
    
    // MARK: Properties
    var items = [Picture]() {
        didSet {
            didItemsUpdated?()
        }
    }
    
    // MARK: Methods
    func getTestFavoritePictures() {
        items = Array(repeating: Picture.createDefault(), count: 5)
    }
}
