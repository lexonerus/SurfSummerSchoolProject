//
//  AuthService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct AuthService {
    let loginDataTask = BaseNetworkTask<AuthRequestModel, AuthResponceModel>(
        isNeedToken: false,
        method: .post,
        path: "auth/login"
    )

    let logoutDataTask = BaseNetworkTask<EmptyModel, EmptyModel> (
        isNeedToken: true,
        method: .post,
        path: "auth/logout"
    )
    
    let service = ProfileService.shared
    
    func performLoginRequestAndSaveToken(
        credentials: AuthRequestModel,
        _ onResponceWasReceived: @escaping (_ result: Result<AuthResponceModel, Error>) -> Void
    ) {
        loginDataTask.performRequest(input: credentials) { result in
            if case let .success(responceModel) = result {

                // TODO: implement profile cache
                service.setProfileModel(model: responceModel.user_info)
                service.saveDataToUserDefaults()
                
                print(responceModel.token)
                
                do {
                try loginDataTask.tokenStorage.set(newToken: TokenContainer(token: responceModel.token, receivingDate: .now))
            } catch {
                // TODO: Error if token was not received
                print("token was not received")
            }
        }
        onResponceWasReceived(result)
        }
    }
    
    func performLogoutRequest(_ onResponceWasReceived: @escaping (_ result: Result<EmptyModel, Error>) -> Void) {
        logoutDataTask.performRequest(onResponceWasReceived)
    }
}
