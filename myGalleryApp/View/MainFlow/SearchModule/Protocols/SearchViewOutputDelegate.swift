//
//  ProtocolSearchViewOutputDelegate.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 04.08.2022.
//

import Foundation

protocol SearchViewOutputDelegate: AnyObject {
    func getDataFromModel()
    func saveDataToModel()
}
