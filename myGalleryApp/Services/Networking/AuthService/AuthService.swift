//
//  AuthService.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct AuthService {
    
    // MARK: Properties
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
    
    
    // MARK: Methods
    func performLoginRequestAndSaveToken(
        credentials: AuthRequestModel,
        _ onResponceWasReceived: @escaping (_ result: Result<AuthResponceModel, Error>) -> Void
    ) {
        loginDataTask.performRequest(input: credentials) { result in
            if case let .success(responceModel) = result {
                service.setProfileModel(model: responceModel.user_info)
                service.saveDataToUserDefaults()
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
    
    func performLogoutRequest(_ onResponceWasReceived: @escaping (_ result: Result<String, Error>) -> Void) {
        logoutDataTask.performRequestWithoutResponce(input: EmptyModel()) { result in
            if case .success(_) = result {
                do {
                    try logoutDataTask.tokenStorage.removeTokenFromContainer()
                    onResponceWasReceived(result)
                } catch {
                    print(error)
                }
            }
        }
        
    }
}
