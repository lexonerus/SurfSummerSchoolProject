//
//  MainViewPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import Foundation
import UIKit

protocol MainViewPresenterDelegate: AnyObject {
    func showDetails(navigation: UINavigationController, item: Picture)
}

class MainViewPresenter {
    
    let view: MainViewController
    let service: FavoriteService
    let model: MainModel
    weak var coordinatorDelegate: MainViewPresenterDelegate?
    
    init(view: MainViewController, model: MainModel, service: FavoriteService, coordinatorDelegate: MainViewPresenterDelegate) {
        self.view = view
        self.model = model
        self.service = service
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func load() {
        
    }
    
    func itemSelected(navigation: UINavigationController, item: Picture) {
        coordinatorDelegate?.showDetails(navigation: navigation, item: item)
    }
    
}
