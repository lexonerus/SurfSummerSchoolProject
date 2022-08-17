//
//  MainViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    var presenter: MainViewPresenter!
    weak var coordinator: CoordinatorDelegate?
    weak var viewOutput: MainViewOutput?
    private var defaultView: UIView?
    
    // MARK: Views
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: MainViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        presenter.setViewInput(viewInput: self)
        self.viewOutput = presenter
        configureAppearance()
        defaultView = self.view
        viewOutput?.activateActivityIndicator()
        DispatchQueue.global(qos: .userInteractive).async {
            self.viewOutput?.configureModel()
            self.viewOutput?.reloadData()
        } 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Главная"
        updateCollection()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    // MARK: Actions
    @objc func searchButtonTapped() {
        coordinator?.showSearch(navigation: navigationController!)
    }
    @objc func favoriteButtonTapped(sender: UIButton) {
        viewOutput!.toggleFavorite(index: sender.tag)
    }
    @IBAction func failButtonPressed(_ sender: Any) {
        viewOutput?.reloadData()
    }
    
}

// MARK: Private Methods
private extension MainViewController {
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "item-search"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
    }
    func configureAppearance() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.isHidden = true
            self?.mainCollectionView.dataSource = self
            self?.mainCollectionView.delegate = self
            // регистрация ячейки:
            self?.mainCollectionView.register(UINib(nibName: "\(MainCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainCollectionViewCell.self)")
            self?.mainCollectionView.contentInset = CollectionViewConstants.contentInset
        }
    }
}

// MARK: UICollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewOutput?.countItems() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
        
        if let cell = cell as? MainCollectionViewCell {
            let item = viewOutput!.presentPicture(index: indexPath.item)
                cell.title      = item.title
                cell.isFavorite = item.isFavorite
                cell.imageUrlInString = item.imageUrlInString
                cell.itemImage = item.itemImage
                cell.heartButton.tag = item.id
                cell.heartButton.addTarget(self, action: #selector(self.favoriteButtonTapped(sender:)), for: .touchUpInside)
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
        let item = viewOutput!.presentPicture(index: indexPath.item)
        coordinator?.showDetails(navigation: navigationController!, item: item)
    }
    
}

// MARK: MainViewInput delegate
extension MainViewController: MainViewInput {
    func showErrorState() {
        DispatchQueue.main.async {
            let errorState = UINib(nibName: "\(ErrorStateView.self)", bundle: .main).instantiate(withOwner: nil, options: nil).first as! ErrorStateView
            
            errorState.frame = self.view.bounds
            errorState.delegate = self
            self.view = errorState
        }

    }
    func updateCollection() {
        DispatchQueue.main.async() {
            self.mainCollectionView.reloadData()
        }
    }
    func startLoading() {
        DispatchQueue.main.async {
            self.mainCollectionView.isHidden = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    func stopLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.mainCollectionView.isHidden = false
        }
    }
    
}

extension MainViewController: ErrorStateDelegate {
    func refresh() {
        viewOutput?.reloadData()
        self.view = defaultView
    }

}


