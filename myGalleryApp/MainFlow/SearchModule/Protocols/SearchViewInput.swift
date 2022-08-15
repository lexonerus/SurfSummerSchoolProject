//
//  SearchViewInput.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import Foundation

protocol SearchViewInput: AnyObject {
    func updateCollection()
    func showEmptyState()
    func showNoResultState()
    func showSearchState()
}
