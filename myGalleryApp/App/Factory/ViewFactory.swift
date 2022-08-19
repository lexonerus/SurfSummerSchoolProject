//
//  TabViewFactory.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import Foundation
import UIKit

struct ViewFactory {
    static func makeLoginPageScene(delegate: LoginCoordinatorDelegate?) -> LoginPageViewController {
        let viewController = LoginPageViewController()
        let service = AuthService()
        let model = LoginModel()
        let presenter = LoginPagePresenter(view: viewController, model: model, service: service)
        viewController.presenter = presenter
        viewController.coordinator = delegate
        return viewController
    }
    
    static func makeMainScene(delegate: TabCoordinatorDelegate?) -> MainViewController {
        let viewContoller = MainViewController()
        let service = FavoriteService.shared
        let model = MainModel.shared
        let presenter = MainViewPresenter(view: viewContoller, model: model, service: service)
        viewContoller.presenter = presenter
        viewContoller.coordinator = delegate
        return viewContoller
    }
    static func makeDetailsScene(delegate: TabCoordinatorDelegate?, item: Picture) -> DetailsViewController {
        let viewController = DetailsViewController()
        let model = item
        let presenter = DetailsViewPresenter(view: viewController, model: model)
        viewController.presenter = presenter
        viewController.coordinator = delegate
        return viewController
    }
    static func makeFavoriteScene(delegate: TabCoordinatorDelegate?) -> FavoriteViewController {
        let viewController = FavoriteViewController()
        let service = FavoriteService.shared
        let model = MainModel.shared
        let presenter = FavoriteViewPresenter(view: viewController, model: model, service: service)
        viewController.presenter = presenter
        viewController.coordinator = delegate
        return viewController
    }
    static func makeSearchScene(delegate: TabCoordinatorDelegate?) -> SearchViewController {
        let viewContoller = SearchViewController()
        let service = FavoriteService.shared
        let model = MainModel.shared
        let filteredData = [Picture]()
        let presenter = SearchViewPresenter(view: viewContoller, service: service, model: model, filteredData: filteredData)
        viewContoller.presenter = presenter
        viewContoller.coordinator = delegate
        viewContoller.hidesBottomBarWhenPushed = true
        return viewContoller
    }
}
