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
    var presenter: FavoriteViewPresenter!
    weak var coordinator: CoordinatorDelegate?
    weak var viewOutput: FavoriteViewOutput?
    private var currentItemId = 0

    // MARK: FavoriteViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewInput(viewInput: self)
        self.viewOutput = presenter
        configureAppearance()
        viewOutput!.configureModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Избранное"
        updateTable()
    }
        
    // MARK: Actions
    @objc func searchButtonTapped() {
        coordinator?.showSearch(navigation: navigationController!)
    }
    @objc func favoriteButtonTapped(sender: UIButton) {
        self.currentItemId = sender.tag
        let alert = AlertService.createTwoButtonsAlert(title: "Внимание", message: "Вы точно хотите удалить из избранного?", okButtonTitle: "Да, точно", cancelButtonTitle: "Нет", okAction: removeItemFromFavorite, cancelAction: cancelDeletion)
        self.showAlert(alert: alert)
    }
    
    func removeItemFromFavorite() {
        viewOutput!.removeFromFavorite(index: currentItemId)
    }
    func cancelDeletion() {
        print("item was not delete from favorites")
        self.updateTable()
    }
    

}

// MARK: TableView delegate and dataSource
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewOutput!.countItems()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteViewCell.self)")
        let ids = Array(viewOutput!.presentFavoriteItems())
        let item = viewOutput!.findItemInModel(id: ids[indexPath.row])
        if item!.isFavorite == true {
            if let cell = cell as? FavoriteViewCell {
                cell.itemImage = item!.itemImage
                cell.isFavorite = item!.isFavorite
                cell.title = item!.title
                cell.date = item!.dateCreate
                cell.shortDesc = item!.content
                cell.favButton.tag = item!.id
                cell.favButton.addTarget(self, action: #selector(favoriteButtonTapped(sender:)), for: .touchUpInside)
            }
        }

        return cell!

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ids = Array(viewOutput!.presentFavoriteItems())
        let item = viewOutput!.findItemInModel(id: ids[indexPath.row])
        coordinator?.showDetails(navigation: navigationController!, item: item!)
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

extension FavoriteViewController: FavoriteViewInput {
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
