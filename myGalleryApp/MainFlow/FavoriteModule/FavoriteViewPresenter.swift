//
//  FavoriteViewPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import Foundation

class FavoriteViewPresenter {
    
    let view: FavoriteViewController
    let model: MainModel
    let service: FavoriteService
    weak var viewInput: FavoriteViewInput?
    
    init(view: FavoriteViewController, model: MainModel, service: FavoriteService) {
        self.view = view
        self.model = model
        self.service = service
    }
    
    func setViewInput(viewInput: FavoriteViewInput) {
        self.viewInput = viewInput
    }
    
}

extension FavoriteViewPresenter: FavoriteViewOutput {
    func removeFromFavorite(index: Int) {
        service.deletePictureFromFavorite(id: index)
        model.items.filter {$0.id == index}.first?.isFavorite = false
        viewInput!.updateTable()
    }
    func countItems() -> Int {
        return service.favoritePictures.count
    }
    func presentFavoriteItems() -> Set<Int> {
        return service.favoritePictures
    }
    func presentPicture(index: Int) -> Picture {
        return model.items[index]
    }
    
    func findItemInModel(id: Int) -> Picture? {
        if let item = model.items.first(where: { $0.id == id }) {
            return item
        } else {
            print("This item doesnt exist")
            return nil
        }
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            self?.viewInput!.updateTable()
        }
    }
}
