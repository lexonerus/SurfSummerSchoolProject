//
//  FavoriteViewOutput.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import Foundation

protocol FavoriteViewOutput: AnyObject {
    func removeFromFavorite(index: Int)
    func countFavorites()           -> Int
    func presentFavoriteItems()     -> Set<Int>
    func presentPicture(index: Int) -> Picture
    func getItem(id: Int)           -> Picture?
    func configureModel()
    func checkState()
}
