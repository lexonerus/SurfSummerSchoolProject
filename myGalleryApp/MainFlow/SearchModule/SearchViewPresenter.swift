//
//  SearchViewPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import Foundation

class SearchViewPresenter {
    
    // MARK: Properties
    let view: SearchViewController
    let service: FavoriteService
    let model: MainModel
    var filteredData: [Picture] 
    weak var viewInput: SearchViewInput?
    var isSearching = false
    
    // MARK: Initializers
    init(view: SearchViewController, service: FavoriteService, model: MainModel, filteredData: [Picture]) {
        self.view = view
        self.service = service
        self.model = model
        self.filteredData = filteredData
    }
    
    // MARK: Methods
    func setViewInput(viewInput: SearchViewInput) {
        self.viewInput = viewInput
    }
    func presentSearchState() {
        viewInput?.showSearchState()
    }
    func presentEmptyState() {
        viewInput?.showEmptyState()
    }
    func presentNoResultState() {
        viewInput?.showNoResultState()
    }

}

extension SearchViewPresenter: SearchViewOutput {
    func prepareState() {
        if !isSearching {
            presentEmptyState()
        } else if isSearching && filteredData.isEmpty {
            presentNoResultState()
        } else {
            presentSearchState()
        }
    }
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            self?.viewInput?.updateCollection()
        }
    }
    func toggleFavorite(index: Int) {
        let item = model.findItemInModel(id: index)

        if item?.isFavorite == false {
            service.savePictureToFavorite(id: item!.id)
            model.items.filter {$0.id == index}.first?.isFavorite = true
        } else {
            service.deletePictureFromFavorite(id: item!.id)
            model.items.filter {$0.id == index}.first?.isFavorite = false
        }
    }
    func reloadCollection() {
        viewInput?.updateCollection()
    }
    func findItem(index: Int) -> Picture {
        return model.items[index]
    }
    func performSearch(with text: String) {
        
        filteredData.removeAll()
        
        guard text != "" || text != " " else {
            print("empty search")
            return
        }
        
        for item in model.items {
            let result = text.lowercased()
            let isArrayContain = item.title.lowercased().range(of: result)
            
            if isArrayContain != nil {
                filteredData.append(item)
            }
        }
        
        if text.isEmpty || text == " " {
            isSearching = false
        } else {
            isSearching = true
        }
    }
    
    func countFilteredElements() -> Int {
        return filteredData.count
    }
    
    func presentFilteredElement(index: Int) -> Picture {
        return filteredData[index]
    }

}
