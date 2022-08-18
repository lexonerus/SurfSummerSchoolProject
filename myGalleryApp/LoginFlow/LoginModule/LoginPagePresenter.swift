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
    
    // MARK: Methods
    func setViewInput(viewInput: LoginPageViewInput?) {
        self.viewInput = viewInput
    }
    
}

// MARK: LoginPageViewOutput delegate
extension LoginPagePresenter: LoginPageViewOutput {
    func login() {
        let tempCredentials = AuthRequestModel(phone: "+71234567890-", password: "qwerty")
        AuthService()
            .performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
                switch result {
                case .success:
                    print("login success")
                    //self?.runMainFlow(isLoggedIn: true)
                case .failure:
                    print("login failure")
                    // TODO: Handle error if token was not received
                    //self?.runMainFlow(isLoggedIn: false)
                }
            }
    }
}
