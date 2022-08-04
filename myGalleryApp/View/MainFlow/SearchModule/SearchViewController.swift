//
//  SearchViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    weak private var viewOutputDelegate: SearchViewOutputDelegate?
    private let presenter = SearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewOutputDelegate = presenter
        presenter.setViewInputDelegate(viewInputDelegate: self)
        
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.topItem?.title = ""
        searchBar.placeholder = "Поиск"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(2)
        viewOutputDelegate?.getDataFromModel()
    }



}

extension SearchViewController: SearchViewInputDelegate {
    func setupInitialState() {
        print("initial setup")
    }
    
    func setupData() {
        print("data setting up")
    }
    
    func displayData(data: String) {
        searchBar.text = data
        print("data displayed")
    }
    
    
}
