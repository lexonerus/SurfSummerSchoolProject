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
    let model: ProfileModel
    let service: AuthService
    weak var viewInput: ProfileViewInput?
    private var isFirstRequest = false
    
    // MARK: Initializers
    init(view: ProfileViewController, model: ProfileModel, service: AuthService) {
        self.view = view
        self.model = model
        self.service = service
    }
    
    // MARK: Methods
    func setViewInput(viewInput: ProfileViewInput) {
        self.viewInput = viewInput
    }
    
    
}

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
            self.service.performLogoutRequest() { [weak self] result in
                switch result {
                case .success:
                    print("success")
                    URLCache.shared.removeAllCachedResponses()
                    // TODO: remove profile data from userDefaults
                    UserDefaults.standard.removeSuite(named: "UserAccount")
                    // TODO: coordinator show login flow
                    self?.viewInput?.exitMainFlow()
                case .failure:
                        print("fail")
                }
            }
        }

    }
}
