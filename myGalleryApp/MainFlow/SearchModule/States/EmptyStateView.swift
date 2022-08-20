//
//  EmptyStateView.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 15.08.2022.
//

import UIKit

class EmptyStateView: UIView {
    
    
    @IBOutlet private weak var stateImage: UIImageView!
    @IBOutlet private weak var stateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setImage(image: UIImage) {
        self.stateImage.image = image
    }
    func setLabel(label: String) {
        self.stateLabel.text = label
    }

}
