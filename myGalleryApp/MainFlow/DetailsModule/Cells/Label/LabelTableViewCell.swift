//
//  LabelTableViewCell.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 06.08.2022.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    // MARK: Views
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var postDate:  UILabel!
    
    var title: String? {
        didSet {
            self.postTitle.text = title
        }
    }
    var date: String? {
        didSet {
            self.postDate.text = date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }


    
}
