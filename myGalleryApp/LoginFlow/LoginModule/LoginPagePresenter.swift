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
    
    private var phone: String = ""
    private var password: String = ""
    
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
    
    func setPhoneNumber(phone: String) {
        let digitSet = CharacterSet.decimalDigits
        let result = String(phone.unicodeScalars.filter { digitSet.contains($0) })
        print(result)
        self.phone = ("+" + result)
    }
    func setPassword(password: String) {
        self.password = password
    }
    
    func login() {
        let tempCredentials = AuthRequestModel(phone: self.phone, password: self.password)
        AuthService()
            .performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
                switch result {
                case .success:
                    print("login success")
                    self?.viewInput?.loginPassed()
                case .failure:
                    // TODO: Implement this case
                    print("login failure")
                    print("account not found")
                }
            }
    }
}
