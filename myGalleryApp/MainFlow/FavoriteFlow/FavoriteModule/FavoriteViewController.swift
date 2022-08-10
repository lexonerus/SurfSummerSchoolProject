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
    private let model = MainModel.shared
    let service = FavoriteService.shared

    // MARK: FavoriteViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Избранное"
        updateTable()
    }
        
    // MARK: Actions
    @objc func searchButtonTapped() {
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func favoriteButtonTapped(sender: UIButton) {
        print(sender.tag)
        service.deletePictureFromFavorite(id: sender.tag)
        model.items.filter {$0.id == sender.tag}.first?.isFavorite = false
        updateTable()
    }

}

// MARK: TableView delegate and dataSource
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.favoritePictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteViewCell.self)")
        let ids = Array(service.favoritePictures)
        let item = findItemInModel(id: ids[indexPath.row])
        if item!.isFavorite == true {
            if let cell = cell as? FavoriteViewCell {
                cell.imageUrlInString = item!.imageUrlInString
                cell.isFavorite = item!.isFavorite
                cell.title = item!.title
                cell.date = item!.dateCreate
                cell.shortDesc = item!.content
                cell.favButton.tag = item!.id
                cell.favButton.addTarget(self, action: #selector(favoriteButtonTapped(sender:)), for: .touchUpInside)
            }
        }
        return cell ?? UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ids = Array(service.favoritePictures)
        let item = findItemInModel(id: ids[indexPath.row])
        let detailViewController = DetailTableViewController()
        detailViewController.model = item
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: Private methods
private extension FavoriteViewController {
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func findItemInModel(id: Int) -> Picture? {
        if let item = model.items.first(where: { $0.id == id }) {
            print(item)
            return item
        } else {
            print("This item doesnt exist")
            return nil
        }
    }
     
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self?.tableView.reloadData()
            }
        }
    }
    
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
