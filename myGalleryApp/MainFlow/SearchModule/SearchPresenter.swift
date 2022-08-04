//
//  SearchPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 04.08.2022.
//

import Foundation

class SearchPresenter {
    // MARK: properties
    private let model = SearchModel()
    weak private var viewInputDelegate: SearchViewInputDelegate?
    // MARK: methods
    func setViewInputDelegate(viewInputDelegate: SearchViewInputDelegate?) {
        self.viewInputDelegate = viewInputDelegate
    }
}

// MARK: SearchViewController delegate methods
extension SearchPresenter: SearchViewOutputDelegate {
    func getDataFromModel() {
        let data = model.getData()
        viewInputDelegate?.displayData(data: data)
    }
    func saveDataToModel() {
        print("save data")
    }
}
