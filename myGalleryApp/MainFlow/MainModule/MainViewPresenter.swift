//
//  MainViewPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import Foundation

class MainViewPresenter {
    
    // MARK: Properties
    let view: MainViewController
    let service: FavoriteService
    let model: MainModel
    weak var viewInput: MainViewInput?
    
    // MARK: Initializers
    init(view: MainViewController, model: MainModel, service: FavoriteService) {
        self.view = view
        self.model = model
        self.service = service
    }
    
    // MARK: Methods
    func setViewInput(viewInput: MainViewInput?) {
        self.viewInput = viewInput
    }
    func loadImagesForReuse() {
        DispatchQueue.global(qos: .background).async {
            self.model.didItemsUpdated = { [weak self] in
                for item in self!.model.items {
                    let url = URL(string: item.imageUrlInString)
                    self!.model.loadImage(from: url!, with: item.id) { done in
                        print("image loaded")
                        self!.viewInput?.updateCollection()
                    }
                    
                }
                
            }
        }
    }

}

// MARK: MainViewOutput delegate methods
extension MainViewPresenter: MainViewOutput {
    func prepateImages() {
        loadImagesForReuse()
    }
    func configureModel() {
        loadImagesForReuse()
        
    }
    func activateActivityIndicator() {
        viewInput?.startLoading()
    }
    func deActivateActivityIndicator() {
        viewInput?.stopLoading()
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
        // TODO: remove print
        print(FavoriteService.shared.favoritePictures)
    }
    func presentPicture(index: Int) -> Picture {
         return model.items[index]
    }
    func countItems() -> Int {
        return model.items.count
    }
    func reloadData() {
        if ConnectionService.shared.isConnected {
            model.getPosts { done in
                if done {
                    // normal state
                    self.viewInput?.stopLoading()
                    self.viewInput?.endRefreshControl()
                    self.prepateImages()
                }
                else {
                    return
                }
            }
        } else {
            // error state
            self.viewInput?.showErrorState()
            //self.viewInput?.toggleWarningMessage()
            self.viewInput?.endRefreshControl()
        }
    }

}
