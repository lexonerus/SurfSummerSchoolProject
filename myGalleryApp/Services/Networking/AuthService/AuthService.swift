//
//  AuthService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct AuthService {
    let dataTask = BaseNetworkTask<AuthRequestModel, AuthResponceModel>(
        isNeedToken: false,
        method: .post,
        path: "auth/login"
    )
    
    func performLoginRequestAndSaveToken(
        credentials: AuthRequestModel,
        _ onResponceWasReceived: @escaping (_ result: Result<AuthResponceModel, Error>) -> Void
    ) {
        dataTask.performRequest(input: credentials, onResponceWasReceived)
    }
}
