//
//  ProfileViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: ProfileViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ProfileModel.shared.item)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Профиль"
    }

}
