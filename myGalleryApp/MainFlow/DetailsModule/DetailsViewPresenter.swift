//
//  DetailsViewPresenter.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import Foundation

class DetailsViewPresenter {
    
    // MARK: Properties
    private let view:   DetailsViewController
    private let model:  Picture
    weak var viewInput: DetailsViewInput?
    
    // MARK: Initializers
    init(view: DetailsViewController, model: Picture) {
        self.view  = view
        self.model = model
    }
    
    // MARK: Methods
    func setViewInput(viewInput: DetailsViewInput?) {
        self.viewInput = viewInput
    }
    
}

// MARK: DetailsViewOutput methods
extension DetailsViewPresenter: DetailsViewOutput {
    func presentItem() -> Picture {
        return model
    }
    func reloadData() {
        viewInput!.updateTable()
    }
}
