//
//  SearchViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Views
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    private var isSearching = false
    var presenter: SearchViewPresenter!
    weak var coordinator: CoordinatorDelegate?
    weak var viewOutput: SearchViewOutput?
    
    // MARK: SearchViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewInput(viewInput: self)
        viewOutput = presenter
        navigationItem.titleView = searchBar
        configureAppearance()
        viewOutput?.configureModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    // MARK: Actions
    @objc func favoriteButtonTapped(sender: UIButton) {
        viewOutput!.toggleFavorite(index: sender.tag)
    }

}

// MARK: Private methods
private extension SearchViewController {
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
        collectionView.contentInset = CollectionViewConstants.contentInset
        collectionView.register(UINib(nibName: "\(MainCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainCollectionViewCell.self)")
        

    }
}

// MARK: SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewOutput?.performSearch(with: searchText)
        
        if searchBar.text == "" {
            isSearching = false
            viewOutput?.reloadCollection()
        } else {
            isSearching = true
            viewOutput?.reloadCollection()
        }
    }
    
    
}

// MARK: CollectionView
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewOutput!.countFilteredElements()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainCollectionViewCell {
            let item = viewOutput!.presentFilteredElement(index: indexPath.item)
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.itemImage = item.itemImage
            cell.heartButton.tag = item.id
            cell.heartButton.addTarget(self, action: #selector(favoriteButtonTapped(sender:)), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CollectionViewConstants.calcLayout(frameWidth: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CollectionViewConstants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CollectionViewConstants.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewOutput!.presentFilteredElement(index: indexPath.item)
        coordinator?.showDetails(navigation: navigationController!, item: item)
    }
    
    
}

extension SearchViewController: SearchViewInput {
    func updateCollection() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.collectionView.reloadData()
        }
    }
}
