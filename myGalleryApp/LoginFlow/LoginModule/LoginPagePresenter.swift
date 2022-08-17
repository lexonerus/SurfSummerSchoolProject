//
//  LoginPagePresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import Foundation

class LoginPagePresenter {
    
    // MARK: Properties
    let view: LoginPageViewController
    let model: LoginModel
    let service: AuthService
    weak var viewInput: LoginPageViewInput?
    
    // MARK: Initializers
    init(view: LoginPageViewController, model: LoginModel, service: AuthService) {
        self.view = view
        self.model = model
        self.service = service
    }
    
    func setViewInput(viewInput: LoginPageViewInput?) {
        self.viewInput = viewInput
    }
    
}

extension LoginPagePresenter: LoginPageViewOutput {
    
}
