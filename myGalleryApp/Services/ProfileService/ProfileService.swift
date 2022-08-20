//
//  ProfileService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 19.08.2022.
//

import Foundation

class ProfileService {
    
    // MARK: Properties
    static let shared   = ProfileService()
    let model           = ProfileModel.shared
    let defaults        = UserDefaults.standard
    
    // MARK: Methods
    func setProfileModel(model: AuthProfileModel) {
        self.model.item = model
    }
    
    func saveDataToUserDefaults() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(model.item)
            defaults.set(data, forKey: StringConstants.profileKey)
        } catch {
            print(error)
        }
    }
    
    func loadDataFromUserDefaults() {
        if let data = defaults.data(forKey: StringConstants.profileKey) {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(AuthProfileModel.self, from: data)
                self.setProfileModel(model: result)
            } catch {
                print(error)
            }
        }
    }

    func clearService() {
        defaults.removeObject(forKey: StringConstants.profileKey)
        defaults.synchronize()
    }
    
}
