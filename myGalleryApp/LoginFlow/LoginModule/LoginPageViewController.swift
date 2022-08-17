//
//  LoginPageViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    // MARK: Views
    
    @IBOutlet private weak var loginView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var loginField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    // MARK: Properties
    var presenter: LoginPagePresenter?
    weak var coordinator: LoginCoordinatorDelegate?
    weak var viewOutput: LoginPageViewOutput?

    
    // MARK: LoginPageViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewInput(viewInput: self)
        self.viewOutput = presenter
        loginField.delegate = self
        title = "Вход"
        configureAppearance()
    }

    // MARK: Actions
    @IBAction func login(_ sender: Any) {
        print("Login pressed")
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    
}

// MARK: Private methods
private extension LoginPageViewController {
    func configureAppearance() {
        configureTextField(view: loginView)
        configureTextField(view: passwordView)
        

    }
    func configureTextField(view: UIView) {
        view.backgroundColor = AppColors.textFieldBackground
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: view.frame.height - 1, width: view.frame.width, height: 1.0)
        bottomLine.backgroundColor = AppColors.textFieldBottomLine.cgColor
        view.layer.addSublayer(bottomLine)
    }
}

// MARK: LoginPageViewInput delegate
extension LoginPageViewController: LoginPageViewInput {
    
}

// MARK: LoginField delegat
extension LoginPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        loginField.text = textField.text!.phoneMasking(pattern: "+# (###) ### ## ##", replacementCharacter: "#")
        
        let currentCharacters = textField.text?.count
        let maximumCharacters = 18
        
        return (currentCharacters! < maximumCharacters)
    }
}
