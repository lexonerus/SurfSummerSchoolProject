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
        let viewContoller = MainViewController()
        let service = FavoriteService.shared
        let model = MainModel.shared
        let presenter = MainViewPresenter(view: viewContoller, model: model, service: service)
        viewContoller.presenter = presenter
        viewContoller.coordinator = delegate
        return viewContoller
    }
    static func makeDetailsScene(delegate: CoordinatorDelegate?, item: Picture) -> DetailsViewController {
        let viewController = DetailsViewController()
        let model = item
        let presenter = DetailsViewPresenter(view: viewController, model: model)
        viewController.presenter = presenter
        viewController.coordinator = delegate
        return viewController
    }
}
