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
    
    // MARK: Properties
    private let model = FavoriteService.shared.dataModel

    // MARK: FavoriteViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        //model.getFavoritePosts()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Избранное"
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: Actions
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }

}

// MARK: TableView delegate and dataSource
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteViewCell.self)")
        let item = model.items[indexPath.row]
        
        if let cell = cell as? FavoriteViewCell {
            cell.imageUrlInString = item.imageUrlInString
            cell.isFavorite = item.isFavorite
            cell.title = item.title
            cell.date = item.dateCreate
            cell.shortDesc = item.content
        }
        
        return cell ?? UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailTableViewController()
        detailViewController.model = model.items[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
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
