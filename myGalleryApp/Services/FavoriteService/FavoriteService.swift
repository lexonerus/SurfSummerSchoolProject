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
    
    // MARK: Methods
    func savePictureToFavorite(id: Int) {
        
    }
    
    func deletePictureFromFavorite(id: Int) {
        
    }
    
    func saveDataToUserDefaults(favoriteArray: [Picture]) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: favoriteArray)
        defaults.set(encodedData, forKey: "Favorite")
    }
    
    func loadDataFromUserDefaults() -> [Picture] {
        let decodedData = defaults.data(forKey: "Favorite")
        let result = NSKeyedUnarchiver.unarchiveObject(with: decodedData!) as! [Picture]
        return result
    }
}
