//
//  ErrorStateView.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 13.08.2022.
//

import UIKit

class ErrorStateView: UIView {

    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    
    weak var delegate: ErrorStateDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureAppearance()
    }
    
    @IBAction func refresh(_ sender: Any) {
        delegate?.refresh()
    }
    
    func configureAppearance() {
        DispatchQueue.main.async {
            self.stateLabel.text = StringConstants.mainEmptyState
        }
    }

}
