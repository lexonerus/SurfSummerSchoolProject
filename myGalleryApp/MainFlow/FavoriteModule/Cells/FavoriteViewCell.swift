//
//  FavoriteViewCell.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 07.08.2022.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    
    // MARK: View
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var favTitle: UILabel!
    @IBOutlet weak var favDate: UILabel!
    @IBOutlet weak var favShortDescription: UILabel!
    
    // MARK: Constans
    private enum Constants {
        static let fillHeartImage   = UIImage(named: "heart-fill")
        static let linedHeartImage  = UIImage(named: "heart-line")
    }
    
    // MARK: Properties
    var itemImage = UIImage(named: "placeholder") {
        didSet {
            favImage.image = itemImage
        }
    }
    var isFavorite: Bool = false {
        didSet {
            let image = isFavorite ? Constants.fillHeartImage : Constants.linedHeartImage
            favButton.setImage(image , for: .normal)
        }
    }
    var title: String = "" {
        didSet {
            favTitle.text = title
        }
    }
    var date: String = "" {
        didSet {
            favDate.text = date
        }
    }
    var shortDesc: String = "" {
        didSet {
            favShortDescription.text = shortDesc
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
    
    // MARK: FavoriteViewCell lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

// MARK: MainCollectionView extensions
private extension FavoriteViewCell {
    func configureAppearance() {
        
        favImage.layer.cornerRadius = 12
        favImage.contentMode = .scaleAspectFill
        
        favTitle.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        
        favDate.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)
        favDate.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        favShortDescription.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        
        selectionStyle = .none
        
    }
}
