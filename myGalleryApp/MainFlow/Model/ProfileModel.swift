//
//  ProfileModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 19.08.2022.
//

import Foundation

final class ProfileModel: Codable {
    
    var item: AuthProfileModel?

    static let shared = ProfileModel()
}
