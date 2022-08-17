//
//  DetailItemModule.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 06.08.2022.
//

import Foundation
import UIKit.UIImage

class Picture {  
    
    // MARK: Properties
    let id: Int
    var itemImage: UIImage
    let imageUrlInString: String
    let title: String
    var isFavorite: Bool
    let dateCreate: String
    let content: String
    
    // MARK: Initialization
    internal init(id: Int, itemImage: UIImage, imageUrlInString: String, title: String, isFavorite: Bool, content: String, dateCreate: Date) {
        self.id = id
        self.itemImage = itemImage
        self.imageUrlInString = imageUrlInString
        self.title = title
        self.isFavorite = isFavorite
        self.content = content
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        self.dateCreate = formatter.string(from: dateCreate)
    }
    
    
    // MARK: Default data
    static func createDefault() -> Picture {
        .init(id: 0, itemImage: UIImage(named: "placeholder")!, imageUrlInString: "", title: "Самый милый корги", isFavorite: false, content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам.  \n \nТеперь, кроме регулировки экстракции, настройки помола, времени заваривания и многого что помогает выделять нужные характеристики кофе, вы сможете выбрать и кружку для кофе в зависимости от сорта.", dateCreate: Date())
    }
}
