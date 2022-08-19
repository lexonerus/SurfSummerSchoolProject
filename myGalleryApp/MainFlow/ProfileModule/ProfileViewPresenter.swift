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
    weak var viewInput: ProfileViewInput?
    
    // MARK: Initializers
    init(view: ProfileViewController, model: ProfileModel) {
        self.view = view
        self.model = model
    }
    
    // MARK: Methods
    func setViewInput(viewInput: ProfileViewInput) {
        self.viewInput = viewInput
    }
    
    
}

extension ProfileViewPresenter: ProfileViewOutput {
    
}
