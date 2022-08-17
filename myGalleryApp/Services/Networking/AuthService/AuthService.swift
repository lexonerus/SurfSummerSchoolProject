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
        dataTask.performRequest(input: credentials) { result in
            if case let .success(responceModel) = result {
                
                // TODO: remove print
                print(responceModel.user_info)
                
                do {
                try dataTask.tokenStorage.set(newToken: TokenContainer(token: responceModel.token, receivingDate: .now))
            } catch {
                // TODO: Error if token was not received
                print("token was not received")
            }
        }
        onResponceWasReceived(result)
        }
    }
}
