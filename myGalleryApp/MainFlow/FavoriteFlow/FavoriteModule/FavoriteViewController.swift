//
//  FavoriteViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 07.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: Views
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: FavoriteViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Избранное"
    }
    
    // MARK: Actions
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }

}

// MARK: TableView delegate and dataSource
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteViewCell.self)")
        
        if let cell = cell as? FavoriteViewCell {
            cell.image = UIImage(named: "cup-of-tea")
            cell.isFavorite = true
            cell.title = "Первыq день в Surf"
            cell.date = "07.08.2022"
            cell.shortDesc = "Ультра короткое описание в одну строчку чтобы она не влезла"
        }
        
        return cell ?? UITableViewCell()

    }
    
    
}

// MARK: Private methods
private extension FavoriteViewController {
    func configureAppearance() {
        configureNavigationBar()
        configureTableView()
        
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(FavoriteViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(FavoriteViewCell.self)")
        tableView.separatorStyle = .none
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "item-search"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    
}
