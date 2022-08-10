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
    private let model = MainModel.init()
    let service = FavoriteService.shared

    // MARK: FavoriteViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        getData()
        //model.getFavoritePosts()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Избранное"
        //configureModel()
        getData()
        DispatchQueue.main.async() {
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
    func findItemInModel(id: Int) -> Picture? {
        if let item = model.items.first(where: { $0.id == id }) {
            print(item)
            return item
        } else {
            print("This item doesnt exist")
            return nil
        }
    }
    
    func getData() {
        model.getPosts { doneWorking in
            print("data loaded")
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async() {
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
