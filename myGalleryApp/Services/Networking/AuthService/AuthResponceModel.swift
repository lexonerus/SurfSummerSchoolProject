//
//  AuthResponceModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct AuthResponceModel: Decodable {
    let user_info: AuthProfileModel
    let token:     String
}


