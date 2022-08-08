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
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                return
            }
            postImage.loadImage(from: url)
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
