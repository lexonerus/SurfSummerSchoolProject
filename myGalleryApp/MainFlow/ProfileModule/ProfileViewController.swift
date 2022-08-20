//
//  ProfileViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: Views
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Properties
    var presenter: ProfileViewPresenter!
    weak var coordinator: TabCoordinatorDelegate?
    weak var viewOutput: ProfileViewOutput?
    var isDarkContentBackground = false
    private var isWarningShows = false
    
    // MARK: Programmatically views
    private var redView = UIView()
    
    // MARK: ProfileViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        presenter.setViewInput(viewInput: self)
        self.viewOutput = presenter
        configureAppearance()
        configureRedView()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Профиль"
    }

    // MARK: Actions
    @IBAction func logoutButton(_ sender: Any) {
        toggleWarningMessage()
//        let alert = AlertService.createTwoButtonsAlert(title: "Внимание", message: "Вы точно хотите выйти из приложения?", okButtonTitle: "Да, точно", cancelButtonTitle: "Нет", okAction: confirmLogout, cancelAction: cancelLogout)
//        self.showAlert(alert: alert)
    }
}

// MARK: Private methods
private extension ProfileViewController {
    func statusBarEnterDarkBackground() {
        isDarkContentBackground = true
        self.navigationController?.navigationBar.barStyle = .black
    }
    func statusBarEnterLightBackground() {
        isDarkContentBackground = false
        self.navigationController?.navigationBar.barStyle = .default
    }
    @objc func confirmLogout() {
        viewOutput?.logout()
    }
    @objc func cancelLogout() {
        print("cancel")
    }
    func configureAppearance() {
        configureTableView()
    }
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(ProfileImageCell.self)", bundle: .main), forCellReuseIdentifier: "\(ProfileImageCell.self)")
        tableView.register(UINib(nibName: "\(ProfileInfoCell.self)", bundle: .main), forCellReuseIdentifier: "\(ProfileInfoCell.self)")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    func configureRedView() {
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        redView.backgroundColor = AppColors.attentionRed
        redView.isHidden = true
    }
}

// MARK: ProfileViewInput delegate
extension ProfileViewController: ProfileViewInput {
    func exitMainFlow() {
        coordinator?.finishMainFlow()
    }
    func toggleWarningMessage() {
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
                self.statusBarEnterDarkBackground()
                self.redView.isHidden = false
                self.redView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
                self.title = "Не удалось выйти, попробуйте еще раз"
                self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14)]
                self.loadViewIfNeeded()
            })
            let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.hideWarning), userInfo: nil, repeats: false)
            
        }
    }
    @objc func hideWarning() {
        redView.isHidden = true
        statusBarEnterLightBackground()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)]
        title = "Профиль"
    }
}

// MARK: TableView
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileImageCell.self)")
            if let cell = cell as? ProfileImageCell {
                cell.avaUrl = viewOutput!.getAvatar()
                cell.name = viewOutput!.getName()
                cell.status = viewOutput!.getStatus()
            }
            return cell ?? UITableViewCell()
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileInfoCell.self)")
            if let cell = cell as? ProfileInfoCell {
                cell.label = "Город"
                cell.field = viewOutput!.getCity()
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileInfoCell.self)")
            if let cell = cell as? ProfileInfoCell {
                cell.label = "Телефон"
                let phone = viewOutput!.getPhone()
                cell.field = phone.phoneMasking(pattern: "+# (###) ### ## ##", replacementCharacter: "#")
            }
            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileInfoCell.self)")
            if let cell = cell as? ProfileInfoCell {
                cell.label = "Почта"
                cell.field = viewOutput!.getEmail()
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    
}
