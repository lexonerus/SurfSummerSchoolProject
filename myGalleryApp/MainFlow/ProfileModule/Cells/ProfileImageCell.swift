//
//  ProfileImageCell.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 19.08.2022.
//

import UIKit

class ProfileImageCell: UITableViewCell {
    
    
    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    
    var avaUrl: String = "" {
        didSet {
            guard let url = URL(string: avaUrl) else {
                return
            }
            avatarView.loadImage(from: url)
        }
    }
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    var status: String = "" {
        didSet {
            statusLabel.text = status
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

private extension ProfileImageCell {
    func configureAppearance() {
        avatarView.layer.cornerRadius = 12
        selectionStyle = .none
        
    }
}
