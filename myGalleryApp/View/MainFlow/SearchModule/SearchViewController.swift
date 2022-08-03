//
//  SearchViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Поиск"

    }



}
