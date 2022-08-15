//
//  SearchViewOutput.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import Foundation

protocol SearchViewOutput: AnyObject {
    func prepareState()
    func toggleFavorite(index: Int)
    func reloadCollection()
    func performSearch(with text: String)
    func countFilteredElements() -> Int
    func presentFilteredElement(index: Int) -> Picture
    func configureModel()
    func presentEmptyState()
    func presentSearchState()
}
