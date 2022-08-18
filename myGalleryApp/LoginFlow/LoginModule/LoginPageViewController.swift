//
//  LoginPageViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    // MARK: Views
    @IBOutlet private weak var eyeButton:       UIButton!
    @IBOutlet private weak var loginView:       UIView!
    @IBOutlet private weak var passwordView:    UIView!
    @IBOutlet private weak var loginField:      UITextField!
    @IBOutlet private weak var passwordField:   UITextField!
    @IBOutlet private weak var loginButton:     UIButton!
    
    // MARK: Programmatically views
    private var emptyLoginWarning    =  UILabel()
    private var emptyPasswordWarning =  UILabel()
    
    // MARK: Constraints
    @IBOutlet weak var loginViewTopConstraint:      NSLayoutConstraint!
    @IBOutlet weak var passwordViewTopConstraint:   NSLayoutConstraint!
    @IBOutlet weak var loginButtonTopConstraint:    NSLayoutConstraint!
    
    // MARK: Properties
    var presenter:          LoginPagePresenter?
    weak var coordinator:   LoginCoordinatorDelegate?
    weak var viewOutput:    LoginPageViewOutput?
    private var isWarningShows = false
    
    // MARK: LoginPageViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewInput(viewInput: self)
        self.viewOutput = presenter
        title = "Вход"
        
        view.addSubview(emptyLoginWarning)
        view.addSubview(emptyPasswordWarning)
        
        configureAppearance()
        configureWarningLabels(label: emptyLoginWarning, view: loginView)
        configureWarningLabels(label: emptyPasswordWarning, view: passwordView)
        
    }

    // MARK: Actions
    @IBAction private func login(_ sender: Any) {

        if loginField.text!.isEmpty || passwordField.text!.isEmpty {
            isWarningShows = true
            toggleWarningMessage()
        } else {
            isWarningShows = false
            toggleWarningMessage()
        }
        
        viewOutput!.setPhoneNumber(phone: self.loginField.text!)
        viewOutput!.setPassword(password: self.passwordField.text!)
        viewOutput!.login()
    }
    @IBAction private func eyeAction(_ sender: Any) {
        let condition = passwordField.isSecureTextEntry ? false : true
        let image = passwordField.isSecureTextEntry ? UIImage(named: "show_password") : UIImage(named: "hide_password")
        passwordField.isSecureTextEntry = condition
        eyeButton.setImage(image, for: .normal)
    }
}

// MARK: Animation
private extension LoginPageViewController {
    // TODO: replace digits with constants
    func expandTextFields() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.loginViewTopConstraint.constant = 5
            self.passwordViewTopConstraint.constant = 40
            self.loginButtonTopConstraint.constant = 56
            self.view.layoutIfNeeded()
            
        })
    }
    func moveBackTextFields() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.loginViewTopConstraint.constant = 25
            self.passwordViewTopConstraint.constant = 16
            self.loginButtonTopConstraint.constant = 32
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: Private methods
private extension LoginPageViewController {
    func toggleWarningMessage() {
        if isWarningShows {
            configureAttentionTextField(view: loginView)
            emptyLoginWarning.isHidden = false
            configureAttentionTextField(view: passwordView)
            emptyPasswordWarning.isHidden = false
            expandTextFields()
        } else {
            configureNormalTextField(view: loginView)
            emptyLoginWarning.isHidden = true
            configureNormalTextField(view: passwordView)
            emptyPasswordWarning.isHidden = true
            moveBackTextFields()
        }
    }
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
    // TODO: replace digits with constants
    func configureWarningLabels(label: UILabel, view: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.text = "Поле не может быть пустым"
        label.textColor = AppColors.attentionRed
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
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
    func loginPassed() {
        coordinator?.loginPassed()
    }
}

// MARK: LoginField delegate
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

