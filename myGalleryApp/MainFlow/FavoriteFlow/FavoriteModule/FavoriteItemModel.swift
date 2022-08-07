//
//  FavoriteItemModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 07.08.2022.
//

import Foundation
import UIKit.UIImage

struct FavoriteItemModel {
    let image: UIImage
    let title: String
    let isFavorite: Bool
    let dateCreate: String
    let content: String
    
    static func createDefault() -> FavoriteItemModel {
        .init(image: UIImage(named: "cup-of-tea")!, title: "Чошечка кофe", isFavorite: true, dateCreate: "07.08.2022", content: "Длинный текст, такой, чтобы не уместился в одну строку")
    }
}
