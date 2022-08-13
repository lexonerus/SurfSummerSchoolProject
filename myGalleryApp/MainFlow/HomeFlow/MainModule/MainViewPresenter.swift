//
//  MainViewPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import Foundation

class MainViewPresenter {
    
    let view: MainViewController
    let service: FavoriteService
    let model: MainModel
    
    weak var viewInput: MainViewInput?
    
    init(view: MainViewController, model: MainModel, service: FavoriteService) {
        self.view = view
        self.model = model
        self.service = service
    }
    
    func setViewInput(viewInput: MainViewInput?) {
        self.viewInput = viewInput
    }

    func updateCollection() {
        model.didItemsUpdated = { [weak self] in
            self?.viewInput?.updateCollection()
        }
    }
    
}

extension MainViewPresenter: MainViewOutput {
    func updateFavorite(index: Int) {
        let item = model.findItemInModel(id: index)

        if item?.isFavorite == false {
            service.savePictureToFavorite(id: item!.id)
            model.items.filter {$0.id == index}.first?.isFavorite = true
        } else {
            service.deletePictureFromFavorite(id: item!.id)
            model.items.filter {$0.id == index}.first?.isFavorite = false
        }
        print(service.favoritePictures)
        
    }
    
    func findItem(index: Int) -> Picture {
        return model.items[index]
    }
    
    func presentPicture(index: Int) -> Picture {
        let picture = model.items[index]
        return picture
    }
    
    func countItems() -> Int {
        return model.items.count
    }
    
    func reloadData() {
        model.getPosts { done in
            print("Data loaded from presenter")
            self.updateCollection()
        }
    }

}
