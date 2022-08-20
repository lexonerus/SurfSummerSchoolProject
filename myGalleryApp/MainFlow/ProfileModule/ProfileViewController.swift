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
    
    // MARK: ProfileViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewInput(viewInput: self)
        self.viewOutput = presenter
        configureAppearance()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Профиль"
    }

    @IBAction func logoutButton(_ sender: Any) {
        viewOutput?.logout()
    }
}

private extension ProfileViewController {
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
}

// MARK: ProfileViewInput delegate
extension ProfileViewController: ProfileViewInput {
    func exitMainFlow() {
        coordinator?.finishMainFlow()
    }
}

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
