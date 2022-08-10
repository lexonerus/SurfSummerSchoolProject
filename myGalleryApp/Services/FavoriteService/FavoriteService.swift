//
//  FavoriteService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 09.08.2022.
//

import Foundation

class FavoriteService {
    
    // MARK: Properties
    let dataModel = FavoriteModelMain()
    let defaults = UserDefaults.standard
    static let shared = FavoriteService()
    var favoritePictures = Set<Int>()
    
    var favoriteItems = Set<Int>() {
        didSet {
            self.favoritePictures = favoriteItems
        }
    }
    
    // MARK: Methods
    func savePictureToFavorite(id: Int) {
        favoritePictures.insert(id)
    }
    
    func deletePictureFromFavorite(id: Int) {
        favoritePictures.remove(id)
    }
    
    func saveDataToUserDefaults() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favoritePictures)
            defaults.set(data, forKey: "favorite")
        } catch {
            print(error)
        }
    }
    
    func loadDataFromUserDefaults() {
        if let data = defaults.data(forKey: "favorite") {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Set<Int>.self, from: data)
                self.favoriteItems = result
            } catch {
                print(error)
            }
        }
        
    }
    
    func checkIsFavorite(id: Int) -> Bool {
        if favoritePictures.contains(id) {
            return true
        } else {
            return false
        }
    }
}
