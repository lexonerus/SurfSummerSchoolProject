//
//  LoginPageViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 17.08.2022.
//

import UIKit


final class LoginPageViewController: UIViewController {
    
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
    private var loginLabel = UILabel()
    private var passwordLabel = UILabel()
    private var redView = UIView()
    
    // MARK: Constraints
    @IBOutlet weak var loginViewTopConstraint:      NSLayoutConstraint!
    @IBOutlet weak var passwordViewTopConstraint:   NSLayoutConstraint!
    @IBOutlet weak var loginButtonTopConstraint:    NSLayoutConstraint!
    
    // MARK: Properties
    var presenter:          LoginPagePresenter?
    weak var coordinator:   LoginCoordinatorDelegate?
    weak var viewOutput:    LoginPageViewOutput?
    private var isWarningShows = false
    private var isStatusBarBlack = true
    var isDarkContentBackground = false

    
    // MARK: LoginPageViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewInput(viewInput: self)
        self.viewOutput = presenter
        title = StringConstants.loginTitle
        
        view.addSubview(emptyLoginWarning)
        view.addSubview(emptyPasswordWarning)
        view.addSubview(loginLabel)
        view.addSubview(passwordLabel)
        view.addSubview(redView)
        
        configureAppearance()
        configureWarningLabels(label: emptyLoginWarning, view: loginView)
        configureWarningLabels(label: emptyPasswordWarning, view: passwordView)
        configureSecondLabels(label: loginLabel, view: loginField)
        configureRedView()
        loginLabel.text = StringConstants.loginLabel
        configureSecondLabels(label: passwordLabel, view: passwordField)
        passwordLabel.text = StringConstants.passLabel
    }
    
    // MARK: Actions
    @IBAction private func login(_ sender: Any) {
        
        // TODO: set activity indicator while login proceed
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
        let image = passwordField.isSecureTextEntry ? UIImage(named: StringConstants.showPass) : UIImage(named: StringConstants.hidePass)
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
    func statusBarEnterDarkBackground() {
        isDarkContentBackground = true
        self.navigationController?.navigationBar.barStyle = .black
    }
    func statusBarEnterLightBackground() {
        isDarkContentBackground = false
        self.navigationController?.navigationBar.barStyle = .default
    }
    @objc func hideWarning() {
        redView.isHidden = true
        statusBarEnterLightBackground()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)]
        title = StringConstants.loginTitle
    }
}

// MARK: Private methods
private extension LoginPageViewController {
    // TODO: Find out why not work?
    func toggleStatus() {
        if isStatusBarBlack {
            navigationController?.navigationBar.barStyle = .black
            setNeedsStatusBarAppearanceUpdate()
        } else {
            navigationController?.navigationBar.barStyle = .default
            setNeedsStatusBarAppearanceUpdate()
        }
        
    }
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
        
        eyeButton.tintColor = AppColors.unselected

        eyeButton.isHidden = true
    }
    
    // TODO: replace digits with constants
    func configureWarningLabels(label: UILabel, view: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.text = StringConstants.warningEmptyField
        label.textColor = AppColors.redBanner
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
    }
    func configureSecondLabels(label: UILabel, view: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        label.textColor = AppColors.unselected
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
        view.layer.sublayers![1].backgroundColor = AppColors.redBanner.cgColor
    }
    func configureNormalTextField(view: UIView) {
        view.layer.sublayers![1].frame = CGRect(x: 0, y: view.frame.height - 1, width: view.frame.width, height: 1.0)
        view.layer.sublayers![1].backgroundColor = AppColors.textFieldBottomLine.cgColor
    }
    func configureRedView() {
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        redView.backgroundColor = AppColors.redBanner
        redView.isHidden = true
    }
}

// MARK: LoginPageViewInput delegate
extension LoginPageViewController: LoginPageViewInput {
    func loginPassed() {
        DispatchQueue.main.sync {
            self.statusBarEnterLightBackground()
        }
        
        coordinator?.loginPassed()
    }
    func setWarningAppearance() {
        DispatchQueue.main.sync {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
                self.statusBarEnterDarkBackground()
                self.redView.isHidden = false
                self.redView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
                self.title = StringConstants.warningWrongLogin
                self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14)]
                self.loadViewIfNeeded()
            })
            let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.hideWarning), userInfo: nil, repeats: false)
        }
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            loginLabel.isHidden = false
            textField.placeholder = ""
        case 1:
            passwordLabel.isHidden = false
            textField.placeholder = ""
        default:
            break
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            if textField.text!.isEmpty {
                loginLabel.isHidden = true
                textField.placeholder = StringConstants.loginLabel
            }
        case 1:
            if textField.text!.isEmpty {
                passwordLabel.isHidden = true
                textField.placeholder = StringConstants.passLabel
            }
        default:
            break
        }
    }
}
