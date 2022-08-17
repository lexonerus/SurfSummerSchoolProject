//
//  LoginPageViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    // MARK: Views
    
    @IBOutlet weak var eyeButton: UIButton!
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
        title = "Вход"
        configureAppearance()
    }

    // MARK: Actions
    @IBAction private func login(_ sender: Any) {
        print("Login pressed")
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    
        if loginField.text!.isEmpty {
            configureAttentionTextField(view: loginView)
        } else {
            configureNormalTextField(view: loginView)
        }
        if passwordField.text!.isEmpty {
            configureAttentionTextField(view: passwordView)
        } else {
            configureNormalTextField(view: passwordView)
        }
    }
    @IBAction private func eyeAction(_ sender: Any) {
        let condition = passwordField.isSecureTextEntry ? false : true
        let image = passwordField.isSecureTextEntry ? UIImage(named: "show_password") : UIImage(named: "hide_password")
        passwordField.isSecureTextEntry = condition
        eyeButton.setImage(image, for: .normal)
    }
    
    
}

// MARK: Private methods
private extension LoginPageViewController {
    func configureAppearance() {
        loginField.tag = 0
        loginField.delegate = self

        passwordField.tag = 1
        passwordField.delegate = self
        
        passwordField.isSecureTextEntry = true
        
        configureTextField(view: loginView)
        configureTextField(view: passwordView)
        
        eyeButton.tintColor = AppColors.unselectedItem

        eyeButton.isHidden = true
        

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
    func configureAttentionTextField(view: UIView) {
        view.layer.sublayers![1].frame = CGRect(x: 0, y: view.frame.height - 1, width: view.frame.width, height: 2.0)
        view.layer.sublayers![1].backgroundColor = AppColors.attentionRed.cgColor
    }
    func configureNormalTextField(view: UIView) {
        view.layer.sublayers![1].frame = CGRect(x: 0, y: view.frame.height - 1, width: view.frame.width, height: 1.0)
        view.layer.sublayers![1].backgroundColor = AppColors.textFieldBottomLine.cgColor
    }
    
}

// MARK: LoginPageViewInput delegate
extension LoginPageViewController: LoginPageViewInput {
    
}

// MARK: LoginField delegat
extension LoginPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 0:
            loginField.text = textField.text!.phoneMasking(pattern: "+# (###) ### ## ##", replacementCharacter: "#")
            let currentCharacters = textField.text?.count
            let maximumCharacters = 18
            return (currentCharacters! < maximumCharacters)
        case 1:
            if textField.text!.isEmpty {
                eyeButton.isHidden = true
            } else {
                eyeButton.isHidden = false
            }
            return true
        default:
            break
        }
        return true
    }

}
