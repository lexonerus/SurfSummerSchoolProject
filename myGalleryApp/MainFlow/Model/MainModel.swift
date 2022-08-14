//
//  MainModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 05.08.2022.
//

import Foundation
import UIKit.UIImage

final class MainModel {
    
    // MARK: Events
    var didItemsUpdated: (() -> Void)?
    
    // MARK: Properties
    static let shared = MainModel.init()
    var items = [Picture]() {
        didSet {
            didItemsUpdated?()
        }
    }
    private let pictureService = PictureService()
    private let favoriteService = FavoriteService.shared
    
    // MARK: Methods
    func getPosts(completionHandler: @escaping (Bool) -> Void) {
        pictureService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { [weak self] pictureModel in
                    
                    let result = Picture(
                        id: Int(pictureModel.id)!,
                        itemImage: UIImage(named: "placeholder")!,
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: (self?.favoriteService.checkIsFavorite(id: Int(pictureModel.id)!))!,
                        content: pictureModel.content,
                        dateCreate: pictureModel.date
                    )

                    return result
                }
            case .failure(_):
                // TODO ErrorState
                completionHandler(false)
                break
            }
        }
        completionHandler(true)
    }
    
    func loadImage(from url: URL, with id: Int, completionHandler: @escaping (Bool) -> Void) {
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                self?.items.first(where: { $0.id == id })!.itemImage = image
                completionHandler(true)
            }
        }
    }
    
    func findItemInModel(id: Int) -> Picture? {
        if let item = items.first(where: { $0.id == id }) {
            print(item)
            return item
        } else {
            print("This item doesnt exist")
            return nil
        }
    }
    

}


