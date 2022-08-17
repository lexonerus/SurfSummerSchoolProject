//
//  NoResultState.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 16.08.2022.
//

import UIKit

class NoResultState: UIView {

    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureAppearance()
    }
    
    func configureAppearance() {
        DispatchQueue.main.async {
            self.stateLabel.text = "По этому запросу нет результатов, \n попробуйте другой запрос"
        }

    }

}
