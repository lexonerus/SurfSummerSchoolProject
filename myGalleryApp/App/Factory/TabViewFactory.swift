//
//  TabViewFactory.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import Foundation
import UIKit

struct TabViewFactory {
    static func makeMainScene(delegate: CoordinatorDelegate?) -> MainViewController {
        let controller = MainViewController()
        let service = FavoriteService.shared
        let model = MainModel.shared
        let presenter = MainViewPresenter(view: controller, model: model, service: service)
        controller.presenter = presenter
        controller.coordinator = delegate
        return controller
    }
}
