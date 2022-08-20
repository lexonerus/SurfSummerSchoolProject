//
//  ProfileInfoCell.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 19.08.2022.
//

import UIKit

class ProfileInfoCell: UITableViewCell {

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var cityField: UILabel!
    
    var label = "" {
        didSet {
            cityLabel.text = label
        }
    }
    var field = "" {
        didSet {
            cityField.text = field 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

private extension ProfileInfoCell {
    func configureAppearance() {
        selectionStyle = .none
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height, width: self.bounds.width, height: 1.0)
        bottomLine.backgroundColor = AppColors.profileBottomLine.cgColor
        self.layer.addSublayer(bottomLine)
    }



}
