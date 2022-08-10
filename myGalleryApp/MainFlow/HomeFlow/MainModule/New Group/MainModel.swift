//
//  MainModel.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 05.08.2022.
//

import Foundation
import UIKit.UIImage

class MainModel {
    
    // MARK: Events
    var didItemsUpdated: (() -> Void)?
    
    // MARK: Properties
    static let shared = MainModel.init()
    var items = [Picture]() {
        // при инициализации не сработает
        // вызовется, когда новое значение будет присвоено items
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
}


