//
//  AuthRequestModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct AuthRequestModel: Encodable {
    let phone: String
    let password: String
}
