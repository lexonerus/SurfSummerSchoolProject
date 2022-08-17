//
//  AuthProfileModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import Foundation

struct AuthProfileModel: Codable {
    let id:         String
    let phone:      String
    let email:      String
    let city:       String
    let firstName:  String
    let lastName:   String
    let avatar:     String
    let about:      String
}
