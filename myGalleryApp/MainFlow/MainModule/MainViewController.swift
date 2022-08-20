//
//  MainViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    var presenter:                      MainViewPresenter!
    weak var coordinator:               TabCoordinatorDelegate?
    weak var viewOutput:                MainViewOutput?
    private var defaultView:            UIView?
    private var isWarningShows          = false
    private var isDarkContentBackground = false
    
    // MARK: Views
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Programmatically views
    private let refreshControl  = UIRefreshControl()
    private var redView         = UIView()
    
    // MARK: MainViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(redView)
        configureNavigationBar()
        presenter.setViewInput(viewInput: self)
        self.viewOutput = presenter
        configureAppearance()
        configureRedView()
        defaultView = self.view
        viewOutput?.activateActivityIndicator()
        DispatchQueue.global(qos: .background).async {
            self.viewOutput?.configureModel()
            self.viewOutput?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = StringConstants.mainTitle
        updateCollection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: Actions
    @objc func refreshControlCalled() {
        viewOutput?.reloadData()
    }
    
    @objc func searchButtonTapped() {
        coordinator?.showSearch(navigation: navigationController!)
    }
    
    @objc func favoriteButtonTapped(sender: UIButton) {
        viewOutput!.toggleFavorite(index: sender.tag)
    }
    
    @IBAction func failButtonPressed(_ sender: Any) {
        viewOutput?.reloadData()
        mainCollectionView.isHidden = true
    }
    
}

// MARK: Private Methods
private extension MainViewController {
    
    @objc func hideWarning() {
        redView.isHidden = true
        statusBarEnterLightBackground()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)]
        title = StringConstants.mainTitle
    }
    
    func statusBarEnterDarkBackground() {
        isDarkContentBackground = true
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    func statusBarEnterLightBackground() {
        isDarkContentBackground = false
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: StringConstants.itemSearch),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
    }
    
    func configureAppearance() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.addTarget(self, action: #selector(self!.refreshControlCalled), for: .valueChanged)
            self?.mainCollectionView.refreshControl = self?.refreshControl
            self?.mainCollectionView.isHidden = true
            self?.mainCollectionView.dataSource = self
            self?.mainCollectionView.delegate = self
            self?.mainCollectionView.register(UINib(nibName: "\(MainCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainCollectionViewCell.self)")
            self?.mainCollectionView.contentInset = CollectionViewConstants.contentInset
        }
    }
    
    func configureRedView() {
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        redView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        redView.backgroundColor = AppColors.attentionRed
        redView.isHidden = true
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
                cell.title              = item.title
                cell.isFavorite         = item.isFavorite
                cell.itemImage          = item.itemImage
                cell.heartButton.tag    = item.id
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.mainCollectionView.isHidden = false
        }
    }
    
    func endRefreshControl() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.mainCollectionView.reloadData()
        }

    }
    
    func toggleWarningMessage() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
                self.statusBarEnterDarkBackground()
                self.redView.isHidden = false
                self.title = StringConstants.warningNoConnection
                self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14)]
                self.redView.backgroundColor = AppColors.attentionRed
                self.loadViewIfNeeded()
            })
            let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.hideWarning), userInfo: nil, repeats: false)
        }
    }
    
}

// MARK: Error state delegate
extension MainViewController: ErrorStateDelegate {
    func refresh() {
        viewOutput?.reloadData()
        self.view = defaultView
    }

}

