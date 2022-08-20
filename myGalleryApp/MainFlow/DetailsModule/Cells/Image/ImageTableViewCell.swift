//
//  ImageTableViewCell.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 06.08.2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
       
    // MARK: Views
    @IBOutlet private var postImage: UIImageView!
        
    // MARK: Properties
    var itemImage = UIImage(named: "placeholder") {
        didSet {
            postImage.image = itemImage
        }
    }
    
    // MARK: ImageTableViewCell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
}

// MARK: MainCollectionView extensions
private extension ImageTableViewCell {
    func configureAppearance() {
        postImage.layer.cornerRadius = 12
        selectionStyle = .none
    }
}
