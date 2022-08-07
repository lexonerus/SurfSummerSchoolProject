//
//  SearchViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: Views
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: Properties
    weak private var viewOutputDelegate: SearchViewOutputDelegate?
    private let presenter = SearchPresenter()
    
    // MARK: SearchViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewOutputDelegate  = presenter
        navigationItem.titleView = searchBar
        presenter.setViewInputDelegate(viewInputDelegate: self)
        viewOutputDelegate?.initialSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(1)
        viewOutputDelegate?.getDataFromModel()
    }
}

// MARK: SearchPresenter delegate methods
extension SearchViewController: SearchViewInputDelegate {
    func setupInitialState() {
        print("initial setup")
        searchBar.placeholder = "Поиск"
    }
    func setupData() {
        print("data setting up")
    }
    func displayData(data: String) {
        searchBar.text = data
        //print("data displayed")
    }
}

// MARK: Private methods
private extension SearchViewController {
    func configureNavigationBar() {
        navigationItem.title = ""
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow-right-line"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}
