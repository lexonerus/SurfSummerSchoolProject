//
//  FavoriteViewPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import Foundation

class FavoriteViewPresenter {
    
    // MARK: Properties
    let view: FavoriteViewController
    let model: MainModel
    let service: FavoriteService
    weak var viewInput: FavoriteViewInput?
    
    // MARK: Initializers
    init(view: FavoriteViewController, model: MainModel, service: FavoriteService) {
        self.view = view
        self.model = model
        self.service = service
    }
    
    // MARK: Methods
    func setViewInput(viewInput: FavoriteViewInput) {
        self.viewInput = viewInput
    }
    
}

// MARK: FavoriteViewOutput methods
extension FavoriteViewPresenter: FavoriteViewOutput {
    func removeFromFavorite(index: Int) {
        service.deletePictureFromFavorite(id: index)
        model.items.filter {$0.id == index}.first?.isFavorite = false
        viewInput!.updateTable()
    }
    func countFavorites() -> Int {
        return service.favoritePictures.count
    }
    func presentFavoriteItems() -> Set<Int> {
        return service.favoritePictures
    }
    func presentPicture(index: Int) -> Picture {
        return model.items[index]
    }
    func getItem(id: Int) -> Picture? {
        return model.findItemInModel(id: id)
    }
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            self?.viewInput!.updateTable()
        }
    }
}
