//
//  MainCollectionViewCell.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 05.08.2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    // MARK: Constans
    private enum Constants {
        static let fillHeartImage   = UIImage(named: "heart-fill")
        static let linedHeartImage  = UIImage(named: "heart-line")
    }
    
    // MARK: Views
    @IBOutlet private var imageView:    UIImageView!
    @IBOutlet private var heartButton:  UIButton!
    @IBOutlet private var cellLabel:    UILabel!
    
    // MARK: Properties
    var title: String = "" {
        didSet {
            cellLabel.text = title
        }
    }
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                return
            }
            imageView.loadImage(from: url)
        }
    }
    var isFavorite: Bool = false {
        didSet {
            let image = isFavorite ? Constants.fillHeartImage : Constants.linedHeartImage
            heartButton.setImage(image , for: .normal)
        }
    }
    
    // MARK: Actions
    @IBAction func heartButtonAction(_ sender: Any) {
        if isFavorite == false {
            isFavorite = true
        } else {
            isFavorite = false
        }
    }
    
    // MARK: MainCollectionViewCell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: MainCollectionView extensions
private extension MainCollectionViewCell {
    func configureAppearance() {
        cellLabel.textColor             = .black
        cellLabel.font                  = .systemFont(ofSize: 12)
        imageView.layer.cornerRadius    = 12
        heartButton.tintColor           = .white
    }
}
