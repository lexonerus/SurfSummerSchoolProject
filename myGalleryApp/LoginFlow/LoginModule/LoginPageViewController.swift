//
//  LoginPageViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    var presenter: LoginPagePresenter?
    weak var coordinator: LoginCoordinatorDelegate?
    weak var viewOutput: LoginPageViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewInput(viewInput: self)
        self.viewOutput = presenter
    }


}

extension LoginPageViewController: LoginPageViewInput {
    
}
