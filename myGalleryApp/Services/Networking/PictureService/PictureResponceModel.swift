//
//  PictureResponceModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct PictureResponceModel: Decodable {
    // MARK: Internal properties
    let id:         String
    let title:      String
    let content:    String
    let photoUrl:   String
    
    var date: Date {
        Date(timeIntervalSince1970: publicationDate / 1000)
    }
    
    // MARK: Private properties
    private let publicationDate: Double
}
   
