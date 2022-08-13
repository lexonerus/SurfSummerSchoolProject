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
    var presenter: MainViewPresenter!
    weak var coordinator: CoordinatorDelegate?
    weak var viewOutput: MainViewOutput?
    
    // MARK: Views
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: MainViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "item-search"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
        presenter.setViewInput(viewInput: self)
        self.viewOutput = presenter
        configureAppearance()
        viewOutput?.activateActivityIndicator()
        viewOutput?.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "Главная"
    }
    
    func setViewOutput(viewOutput: MainViewOutput?) {
        self.viewOutput = viewOutput
    }

    // MARK: Actions
    @objc func searchButtonTapped() {
        coordinator?.showSearch(navigation: navigationController!)
    }
    @objc func favoriteButtonTapped(sender: UIButton) {
        viewOutput!.updateFavorite(index: sender.tag)
    }
    @IBAction func failButtonPressed(_ sender: Any) {
        viewOutput?.reloadData()
    }
    
}

// MARK: Private Methods
private extension MainViewController {
    func configureAppearance() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.isHidden = true
            self?.mainCollectionView.dataSource = self
            self?.mainCollectionView.delegate = self
            // регистрация ячейки:
            self?.mainCollectionView.register(UINib(nibName: "\(MainCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainCollectionViewCell.self)")
            self?.mainCollectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
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
                cell.heartButton.tag = item.id
                cell.heartButton.addTarget(self, action: #selector(self.favoriteButtonTapped(sender:)), for: .touchUpInside)
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
        let item = viewOutput!.findItem(index: indexPath.item)
        coordinator?.showDetails(navigation: navigationController!, item: item)
    }
    
}

// MARK: MainViewInput delegate
extension MainViewController: MainViewInput {
    func showErrorState() {
        let errorState = UINib(nibName: "\(ErrorStateView.self)", bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView
        errorState.frame = self.view.bounds
        self.view.addSubview(errorState)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.mainCollectionView.isHidden = false
        }
    }
    
}


