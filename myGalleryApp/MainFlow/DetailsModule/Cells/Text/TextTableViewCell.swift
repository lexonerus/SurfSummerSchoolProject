//
//  TextTableViewCell.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 06.08.2022.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    // MARK: Views
    @IBOutlet var postDescription: UILabel!
    
    // MARK: Properties
    var post: String? {
        didSet {
            self.postDescription.text = post
        }
    }
    
    // MARK: TextTableViewCell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    
}
