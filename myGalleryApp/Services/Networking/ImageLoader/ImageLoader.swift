//
//  ImageLoader.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation
import UIKit.UIImage

struct ImageLoader {
    
    let queueForLoad = DispatchQueue.global(qos: .userInteractive)
    //let queueForLoad = DispatchQueue.main
    let session = URLSession(configuration: .default)
    
    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                onLoadWasCompleted(.failure(error))
            }
            if let data = data, let image = UIImage(data: data) {
                onLoadWasCompleted(.success(image))
            }
        }
        .resume()
    }
}
