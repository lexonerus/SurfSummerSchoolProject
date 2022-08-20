//
//  ProfileViewPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 19.08.2022.
//

import Foundation

class ProfileViewPresenter {
    
    // MARK: Properties
    let view: ProfileViewController
    let model: ProfileModel!
    let mainModel: MainModel!
    let authService: AuthService!
    let favoriteService: FavoriteService!
    let profileService: ProfileService!
    weak var viewInput: ProfileViewInput?
    private var isFirstRequest = false
    
    // MARK: Initializers
    init(view: ProfileViewController, model: ProfileModel, mainModel: MainModel, authService: AuthService, favoriteService: FavoriteService, profileService: ProfileService) {
        self.view = view
        self.model = model
        self.mainModel = mainModel
        self.authService = authService
        self.favoriteService = favoriteService
        self.profileService = profileService
    }
    
    // MARK: Methods
    func setViewInput(viewInput: ProfileViewInput) {
        self.viewInput = viewInput
    }
    func clearAllUserData() {
        URLCache.shared.removeAllCachedResponses()
        mainModel.clearModel()
        favoriteService.clearService()
        profileService.clearService()
    }
}

// MARK: ProfileViewOutput delegate
extension ProfileViewPresenter: ProfileViewOutput {
    func getAvatar() -> String {
        return model.item!.avatar
    }
    func getName() -> String {
        return "\(model.item!.firstName)\n\(model.item!.lastName)"
    }
    func getStatus() -> String {
        return "«\(model.item!.about)»"
    }
    func getCity() -> String {
        return model.item!.city
    }
    func getPhone() -> String {
        return model.item!.phone
    }
    func getEmail() -> String {
        return model.item!.email
    }
    func logout() {
        DispatchQueue.main.async {
            self.authService.performLogoutRequest() { [weak self] result in
                switch result {
                case .success:
                    self?.clearAllUserData()
                    self?.viewInput?.exitMainFlow()
                case .failure:
                    // TODO: Cannot logout state
                    self?.viewInput?.toggleWarningMessage()
                    print(result)
                }
            }
        }
    }
}
