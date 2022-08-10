//
//  SearchViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    

    // MARK: Constants
    private enum Constants {
        static let horizontalInset: CGFloat         = 16
        static let spaceBetweenElements: CGFloat    = 7
        static let spaceBetweenRows: CGFloat        = 8
    }
    
    // MARK: Views
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: Properties
    private var filteredData = [Picture]()
    private var model: MainModel = MainModel.shared
    private let favoriteService = FavoriteService.shared
    private var isSearching = false

    
    // MARK: SearchViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        configureAppearance()
        configureModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()


    }
    
    // MARK: Actions
    @objc func favoriteButtonTapped(sender: UIButton) {
        let item = findItemInModel(id: sender.tag)

        if item?.isFavorite == false {
            favoriteService.savePictureToFavorite(id: item!.id)
            model.items.filter {$0.id == sender.tag}.first?.isFavorite = true
        } else {
            favoriteService.deletePictureFromFavorite(id: item!.id)
            model.items.filter {$0.id == sender.tag}.first?.isFavorite = false
        }
        print(favoriteService.favoritePictures)
        
    }

}

// MARK: Private methods
private extension SearchViewController {
    func findItemInModel(id: Int) -> Picture? {
        if let item = model.items.first(where: { $0.id == id }) {
            print(item)
            return item
        } else {
            print("This item doesnt exist")
            return nil
        }
    }
    
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
    func configureAppearance() {
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.layer.masksToBounds = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "\(MainCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainCollectionViewCell.self)")
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)

    }
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self?.collectionView.reloadData()
            }
        }
    }
    
}

// MARK: SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData.removeAll()
        
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        
        for item in model.items {
            let text = searchText.lowercased()
            let isArrayContain = item.title.lowercased().range(of: text)
            
            if isArrayContain != nil {
                //print("Search complete")
                print(item.title)
                filteredData.append(item)
            }
        }
        
        if searchBar.text == "" {
            isSearching = false
            collectionView.reloadData()
        } else {
            isSearching = true
            collectionView.reloadData()
        }
    }
    
    
}

// MARK: CollectionView
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainCollectionViewCell {
            let item = filteredData[indexPath.item]
            cell.title      = item.title
            cell.isFavorite = item.isFavorite
            cell.imageUrlInString = item.imageUrlInString
            cell.heartButton.tag = item.id
            cell.heartButton.addTarget(self, action: #selector(favoriteButtonTapped(sender:)), for: .touchUpInside)
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
        detailViewController.model = filteredData[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}


