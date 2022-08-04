//
//  SearchViewInputDelegate.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 04.08.2022.
//

import Foundation

protocol SearchViewInputDelegate: AnyObject {
    func setupInitialState()
    func setupData()
    func displayData(data: String)
}
