//
//  SearchViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: Views
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: Properties
    weak private var viewOutputDelegate: SearchViewOutputDelegate?
    private let presenter = SearchPresenter()
    
    // MARK: SearchViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewOutputDelegate                                 = presenter
        presenter.setViewInputDelegate(viewInputDelegate: self)
        navigationItem.titleView                                = searchBar
        navigationController?.navigationBar.topItem?.title      = ""
        searchBar.placeholder                                   = "Поиск"
        viewOutputDelegate?.initialSetup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(2)
        viewOutputDelegate?.getDataFromModel()
    }
}

// MARK: SearchPresenter delegate methods
extension SearchViewController: SearchViewInputDelegate {
    func setupInitialState() {
        print("initial setup")
    }
    func setupData() {
        print("data setting up")
    }
    func displayData(data: String) {
        searchBar.text = data
        //print("data displayed")
    }
}
