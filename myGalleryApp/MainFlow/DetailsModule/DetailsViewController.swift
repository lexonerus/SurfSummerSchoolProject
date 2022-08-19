//
//  DetailTableViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 06.08.2022.
//

import UIKit

class DetailsViewController: UITableViewController, UIGestureRecognizerDelegate {
        
    // MARK: Properties
    var presenter: DetailsViewPresenter?
    weak var coordinator: TabCoordinatorDelegate?
    weak var viewOutput: DetailsViewOutput?
    private var arrayWithTypeOfCells = [ImageTableViewCell.self, LabelTableViewCell.self, TextTableViewCell.self]
    
    // MARK: DetailTableViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewInput(viewInput: self)
        self.viewOutput = presenter
        configureAppearance()
        configureNavigationBar()
    }
    
    // MARK: Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: refactor logic below
        return arrayWithTypeOfCells.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: refactor logic below
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageTableViewCell.self)")
            
            if let cell = cell as? ImageTableViewCell {
                cell.itemImage = viewOutput?.presentItem().itemImage
            }
            return cell ?? UITableViewCell()
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(LabelTableViewCell.self)")

            if let cell = cell as? LabelTableViewCell {
                cell.title = viewOutput?.presentItem().title ?? "title"
                cell.date  = viewOutput?.presentItem().dateCreate ?? "date"
            }
            
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextTableViewCell.self)")
            
            if let cell = cell as? TextTableViewCell {
                cell.post = viewOutput?.presentItem().content ?? "no description"
            }
            
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
            
        }
    }
}

// MARK: Private methods
private extension DetailsViewController {
    func configureAppearance() {
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = viewOutput?.presentItem().title
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow-right-line"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "\(ImageTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(ImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(LabelTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(LabelTableViewCell.self)")
        tableView.register(UINib(nibName: "\(TextTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(TextTableViewCell.self)")
        tableView.separatorStyle = .none
    }

}

// MARK: DetailsViewInput methods
extension DetailsViewController: DetailsViewInput {
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
