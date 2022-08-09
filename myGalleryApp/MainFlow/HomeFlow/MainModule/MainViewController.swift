//
//  MainViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: Constants
    private enum Constants {
        static let horizontalInset: CGFloat         = 16
        static let spaceBetweenElements: CGFloat    = 7
        static let spaceBetweenRows: CGFloat        = 8
    }
    
    // MARK: Properties
    private let model: MainModel = .init()
    
    // MARK: Views
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var failedView: UIView!
    @IBOutlet weak var failLabel: UILabel!
    @IBOutlet weak var failImage: UIImageView!
    @IBOutlet weak var failButton: UIButton!
    
    // MARK: MainViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "item-search"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
        configureAppearance()
        configureModel()
        getData()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "Главная"
    }

    // MARK: Actions
    @objc func searchButtonTapped() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func failButtonPressed(_ sender: Any) {
        getData()
    }
    

}

// MARK: Private Methods
private extension MainViewController {
    func getData() {
        model.getPosts { doneWorking in
            if doneWorking {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.mainCollectionView.isHidden = false
                }
            } else {
                print("Error")
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.failedView.isHidden = false
                    self.failLabel.text = """
                    Не удалось загрузить ленту
                    Обновите экран или попробуqте позже
                    """
                }
                
            }

        }
    }
    
    func configureAppearance() {
        mainCollectionView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        // регистрация ячейки:
        mainCollectionView.register(UINib(nibName: "\(MainCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainCollectionViewCell.self)")
        mainCollectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.mainCollectionView.reloadData()
            }
            
        }
    }
}

// MARK: UICollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainCollectionViewCell {
            let item = model.items[indexPath.item]
            cell.title      = item.title
            cell.isFavorite = item.isFavorite
            cell.imageUrlInString = item.imageUrlInString
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = ((view.frame.width - (Constants.horizontalInset * 2 ) - Constants.spaceBetweenElements)/2)
        
        return CGSize(width: itemWidth, height: (1.46 * itemWidth))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constants.spaceBetweenElements
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailTableViewController()
        detailViewController.model = model.items[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
