//
//  ProfileViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: Views

    
    // MARK: Properties
    var presenter: ProfileViewPresenter!
    weak var coordinator: TabCoordinatorDelegate?
    weak var viewOutput: ProfileViewOutput?
    
    // MARK: ProfileViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewInput(viewInput: self)
        self.viewOutput = presenter

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Профиль"
    }

    @IBAction func logoutButton(_ sender: Any) {
        viewOutput?.logout()
    }
}

// MARK: ProfileViewInput delegate
extension ProfileViewController: ProfileViewInput {
    func exitMainFlow() {
        coordinator?.finishMainFlow()
    }
}
