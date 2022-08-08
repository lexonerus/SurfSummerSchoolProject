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
    var items = [DetailItemModel]() {
        // при инициализации не сработает
        // вызовется, когда новое значение будет присвоено items
        didSet {
            didItemsUpdated?()
        }
    }
    let pictureService = PictureService()
    
    // MARK: Methods
    func getPosts() {
        pictureService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    DetailItemModel(
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: false, // TODO FavoriteService
                        content: pictureModel.content,
                        dateCreate: pictureModel.date
                    )
                }
            case .failure(let error):
                // TODO ErrorState
                break
            }
        }
        items = Array(repeating: DetailItemModel.createDefault(), count: 50)
    }
}


