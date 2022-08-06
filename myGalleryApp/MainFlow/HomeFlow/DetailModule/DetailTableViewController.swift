//
//  DetailTableViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 06.08.2022.
//

import UIKit

class DetailTableViewController: UITableViewController, UIGestureRecognizerDelegate {
        
    // MARK: Properties
    var model: DetailItemModel?
    
    // MARK: DetailTableViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    
    // MARK: Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageTableViewCell.self)")
            
            if let cell = cell as? ImageTableViewCell {
                cell.image = model?.image
            }
            return cell ?? UITableViewCell()
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(LabelTableViewCell.self)")

            if let cell = cell as? LabelTableViewCell {
                cell.title = model?.title ?? "title"
                cell.date  = model?.dateCreate ?? "date"
            }
            
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextTableViewCell.self)")
            
            if let cell = cell as? TextTableViewCell {
                cell.post = model?.content ?? "no description"
            }
            
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
            
        }
    }
}


// MARK: Private methods
private extension DetailTableViewController {
    func configureAppearance() {
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = model?.title
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
