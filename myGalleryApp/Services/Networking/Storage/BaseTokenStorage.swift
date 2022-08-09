//
//  BaseTokenStorage.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

struct BaseTokenStorage: TokenStorage {
    // MARK: Constants
    private enum Constants {
        static let applicationNameInKeyChain = "ru.lexone.surf.project"
        static let tokenKey = "token"
        static let tokenDateKey = "tokenDate"
    }
    
    // MARK: Private Properties
    private var unprotectedStorage: UserDefaults {
        UserDefaults.standard
    }
    
    // MARK: Token storage
    func getToken() throws -> TokenContainer {
        // Вечный токен, чтобы обойти авторизацию
        //TokenContainer(token: "595d9f58b8ac34689b1326e2cf4ef803882995c267a00ce34c6220f4a6d8ed6a")
        //TokenContainer(token: "")
        
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue
        ]
        
        var tokenInResult: AnyObject?
        let status = SecItemCopyMatching(queryDictionaryForSavingToken as CFDictionary, &tokenInResult)
        
        try throwErrorFromStatusIfNeeded(status)
        
        guard let data = tokenInResult as? Data else {
            throw Error.tokenWasNotFoundInKeyChainOrCantRepresentAsData
        }
        
        let retrivingToken = try JSONDecoder().decode(String.self, from: data)
        let tokenSavingDate = try getSavingTokenDate()
        
        return TokenContainer(token: retrivingToken, receivingDate: tokenSavingDate)
        
    }
    
    func set(newToken: TokenContainer) throws {
        try removeTokenFromContainer()
        
        let tokenInData = try JSONEncoder().encode(newToken.token)
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecValueData: tokenInData as AnyObject
        ]
        
        let status = SecItemAdd(queryDictionaryForSavingToken as CFDictionary, nil)
        
        try throwErrorFromStatusIfNeeded(status)
        
        saveTokenSavingDate(.now)
    }
    
    func removeTokenFromContainer() throws {
        let queryDictionaryForDeleteToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(queryDictionaryForDeleteToken as CFDictionary)
        
        try throwErrorFromStatusIfNeeded(status)
        
        removeTokenSavingDate()
    }
}

// MARK: Private extension
private extension BaseTokenStorage {
    enum Error: Swift.Error {
        case unknownError(status: OSStatus)
        case keyIsAlreadyInKeyChain
        case tokenWasNotFoundInKeyChainOrCantRepresentAsData
        case tokenDateWasNotFound
    }
    
    func getSavingTokenDate() throws -> Date {
        guard let savingDate = unprotectedStorage.value(forKey: Constants.tokenDateKey) as? Date else {
            throw Error.tokenDateWasNotFound
        }
        return savingDate
    }
    
    func saveTokenSavingDate(_ newDate: Date) {
        unprotectedStorage.set(newDate, forKey: Constants.tokenDateKey)
    }
    
    func removeTokenSavingDate() {
        unprotectedStorage.set(nil, forKey: Constants.tokenDateKey)
    }
    
    func throwErrorFromStatusIfNeeded(_ status: OSStatus) throws {
        guard status == errSecSuccess || status == -25300 else {
            throw Error.unknownError(status: status)
        }
        
        guard status != -25299 else {
            throw Error.keyIsAlreadyInKeyChain
        }
    }
}

