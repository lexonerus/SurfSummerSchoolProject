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
    
}
