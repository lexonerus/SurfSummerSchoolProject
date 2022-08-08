//
//  PictureService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct PictureService {
    
    // MARK: Properties
    let dataTask = BaseNetworkTask<EmptyModel, [PictureResponceModel]>(
        isNeedToken: true,
        method: .get,
        path: "picture/"
    )
    
    // MARK: Methods
    func loadPictures(_ onResponceWasReceived: @escaping (_ result: Result<[PictureResponceModel],
                                                          Error>) -> Void) {
        dataTask.performRequest(onResponceWasReceived)
    }
}
