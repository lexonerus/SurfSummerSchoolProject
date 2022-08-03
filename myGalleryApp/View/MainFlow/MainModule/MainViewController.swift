//
//  MainViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View loaded")
        title = "Главная"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "item-search"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("View did appear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("View will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("View did disappear")
    }
    override func didReceiveMemoryWarning() {
        print("iOS memory is not enough!")
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }

}
