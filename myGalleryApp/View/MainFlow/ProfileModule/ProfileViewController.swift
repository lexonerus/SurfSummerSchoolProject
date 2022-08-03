//
//  ProfileViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "item-search"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }

}
