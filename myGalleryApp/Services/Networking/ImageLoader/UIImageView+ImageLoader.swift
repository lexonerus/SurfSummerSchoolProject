//
//  UIImageView+ImageLoader.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
