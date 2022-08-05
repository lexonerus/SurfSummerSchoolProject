//
//  DetaleImageViewCell.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 05.08.2022.
//

import UIKit

class DetaleImageViewCell: UITableViewCell {


    @IBOutlet var cardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
