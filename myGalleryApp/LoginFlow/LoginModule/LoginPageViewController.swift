//
//  LoginPageViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    // MARK: Views
    @IBOutlet private weak var loginField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Properties
    var presenter: LoginPagePresenter?
    weak var coordinator: LoginCoordinatorDelegate?
    weak var viewOutput: LoginPageViewOutput?

    
    // MARK: LoginPageViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewInput(viewInput: self)
        self.viewOutput = presenter
        title = "Вход"
        configureAppearance()
    }

    // MARK: Actions
    @IBAction func login(_ sender: Any) {
    }
    
}

// MARK: Private methods
private extension LoginPageViewController {
    func configureAppearance() {
        configureTextField(textField: loginField)
        configureTextField(textField: passwordField)
    }
    func configureTextField(textField: UITextField) {
        textField.backgroundColor = AppColors.textFieldBackground
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = AppColors.textFieldBottomLine.cgColor
        textField.layer.addSublayer(bottomLine)
        
    }
}

// MARK: LoginPageViewInput delegate
extension LoginPageViewController: LoginPageViewInput {
    
}
