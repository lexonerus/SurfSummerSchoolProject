//
//  BaseTokenStorage.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct BaseTokenStorage: TokenStorage {
    func getToken() throws -> TokenContainer {
        // Вечный токен, чтобы обойти авторизацию
        //TokenContainer(token: "595d9f58b8ac34689b1326e2cf4ef803882995c267a00ce34c6220f4a6d8ed6a")
        TokenContainer(token: "")
    }
    
    func set(newToken: TokenContainer) throws { }
}


