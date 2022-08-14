//
//  DetailsViewOutput.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import Foundation

protocol DetailsViewOutput: AnyObject {
    func reloadData()
    func presentItem() -> Picture
}
