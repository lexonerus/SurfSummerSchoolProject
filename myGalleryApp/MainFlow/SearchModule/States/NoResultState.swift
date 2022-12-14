//
//  NoResultState.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 16.08.2022.
//

import UIKit

class NoResultState: UIView {

    // MARK: Views
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureAppearance()
    }
    
    // MARK: Methods
    func configureAppearance() {
        DispatchQueue.main.async {
            self.stateLabel.text = StringConstants.searchEmptyState
        }
    }

}
