//
//  MainViewOutput.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import Foundation

protocol MainViewOutput: AnyObject {
    
    func activateActivityIndicator()
    func deActivateActivityIndicator()
    func toggleFavorite(index: Int)
    func presentPicture(index: Int) -> Picture
    func countItems() -> Int
    func reloadData()
    func configureModel()
}
