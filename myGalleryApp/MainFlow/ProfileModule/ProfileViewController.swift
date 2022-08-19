//
//  ProfileViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    // MARK: ProfileViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = ProfileModel.shared.item?.firstName ?? "nil"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Профиль"
    }

    @IBAction func logoutButton(_ sender: Any) {
        let service = AuthService()
        service.performLogoutRequest() { result in
            switch result {
            case .success:
                print("success")
                URLCache.shared.removeAllCachedResponses()
                // TODO: remove profile data from userDefaults
                // TODO: coordinator show login flow
            case .failure:
                print("fail")
            }
        }
    }
}
