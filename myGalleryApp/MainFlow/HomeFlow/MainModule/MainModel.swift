//
//  MainModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 05.08.2022.
//

import Foundation
import UIKit.UIImage

final class MainModel {
    
    // MARK: Events
    var didItemsUpdated: (() -> Void)?
    
    // MARK: Properties
    var items = [DetailItemModel]() {
        // при инициализации не сработает
        // вызовется, когда новое значение будет присвоено items
        didSet {
            didItemsUpdated?()
        }
    }
    
    // MARK: Methods
    func getPosts() {
        items = Array(repeating: DetailItemModel.createDefault(), count: 50)
    }
}


