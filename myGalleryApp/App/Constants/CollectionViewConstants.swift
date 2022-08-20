//
//  CollectionViewConstants.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 14.08.2022.
//

import UIKit

struct CollectionViewConstants {
    static let horizontalInset:      CGFloat = 16
    static let spaceBetweenElements: CGFloat = 7
    static let spaceBetweenRows:     CGFloat = 8
    static let contentInset = UIEdgeInsets.init(
        top: 10,
        left: 16,
        bottom: 10,
        right: 16
    )
    
    static func calcLayout(frameWidth: CGFloat) -> CGSize {
        let itemWidth = ((frameWidth - (horizontalInset * 2 ) - spaceBetweenElements) / 2)
        let size = CGSize(width: itemWidth, height: (1.46 * itemWidth))
        return size
    }
}
