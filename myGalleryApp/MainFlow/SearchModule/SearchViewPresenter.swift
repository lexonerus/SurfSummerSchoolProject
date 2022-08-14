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
    func updateCollection() {
        model.didItemsUpdated = { [weak self] in
            self?.viewInput?.updateCollection()
        }
    }
}

extension SearchViewPresenter: SearchViewOutput {
    func configureModel() {
        updateCollection()
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
    }
    
    func countFilteredElements() -> Int {
        return filteredData.count
    }
    
    func presentFilteredElement(index: Int) -> Picture {
        return filteredData[index]
    }

}
