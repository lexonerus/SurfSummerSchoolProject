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
    @IBOutlet private var mainCollectionView: UICollectionView!
    
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
        model.getPosts()
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "Главная"
    }

    // MARK: Actions
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }

}

// MARK: Private Methods
private extension MainViewController {
    func configureAppearance() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        // регистрация ячейки:
        mainCollectionView.register(UINib(nibName: "\(MainCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainCollectionViewCell.self)")
        mainCollectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            self?.mainCollectionView.reloadData()
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
            cell.image      = item.image
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
    
    
}
