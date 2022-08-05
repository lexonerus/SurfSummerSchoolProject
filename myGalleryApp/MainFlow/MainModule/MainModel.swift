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
    var items = [ItemModel]() {
        // при инициализации не сработает
        // вызовется, когда новое значение будет присвоено items
        didSet {
            didItemsUpdated?()
        }
    }
    
    // MARK: Methods
    func getPosts() {
        items = Array(repeating: ItemModel.createDefault(), count: 50)
    }
}

// MARK: Test Data
struct ItemModel {
    
    let image: UIImage
    let title: String
    let isFavorite: Bool
    let dateCreate: String
    let content: String
    
    static func createDefault() -> ItemModel {
        .init(image: UIImage(named: "korgi")!, title: "Самый милый корги", isFavorite: false, dateCreate: "05.08.2022", content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. \n Теперь, кроме регулировки экстракции, настройки помола, времени заваривания и многого что помогает выделять нужные характеристики кофе, вы сможете выбрать и кружку для кофе в зависимости от сорта.")
    }
}
