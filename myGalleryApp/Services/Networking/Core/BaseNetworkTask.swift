//
//  BaseNetworkTask.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation
import UIKit

struct BaseNetworkTask<AbstractInput: Encodable, AbstractOutput: Decodable>: NetworkTask {  

    // MARK: NetworkTask
    typealias Input         = AbstractInput
    typealias Output        = AbstractOutput
    var baseURL:            URL? { URL(string: "https://pictures.chronicker.fun/api") }
    let path:               String
    let method:             NetworkMethod
    let session:            URLSession = URLSession(configuration: .default)
    let isNeedToken:        Bool
    var urlCache:           URLCache { URLCache.shared }
    var tokenStorage: TokenStorage { BaseTokenStorage() }
    
    // MARK: Initialization
    init(isNeedToken: Bool, method: NetworkMethod, path: String ) {
        self.isNeedToken = isNeedToken
        self.path        = path
        self.method      = method
    }
    
    // MARK: Network task
    func performRequestWithoutResponce(
        input: AbstractInput,
        _ onResponceWasReceived: @escaping (_ result: Result<String, Error>) -> Void
    ) {
        do {
            let request = try getRequest(with: input)
            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    onResponceWasReceived(.failure(error))
                } else if let response = response {
                    if let httpResponse = response as? HTTPURLResponse {
                        switch httpResponse.statusCode {
                        case 204:
                            let success = "You are successfully logged out."
                            print(success)
                            onResponceWasReceived(.success(success))
                        case 401:
                            onResponceWasReceived(.failure(NetworkTaskError.notLoggedIn))
                        default:
                            onResponceWasReceived(.failure(NetworkTaskError.unknownError))
                        }
                    }
                } else {
                    onResponceWasReceived(.failure(NetworkTaskError.unknownError))
                }
            }
            .resume()
        } catch {
            onResponceWasReceived(.failure(NetworkTaskError.unknownError))
        }
    }
    
    func performRequest(
            input: AbstractInput,
            _ onResponceWasReceived: @escaping (_ result: Result<AbstractOutput, Error>) -> Void) {
        do {
            let request = try getRequest(with: input)
            
            
            // MARK: get data from chache here
            if let cachedResponse = getCachedResponceFromCache(by: request) {
                let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: cachedResponse.data)
                onResponceWasReceived(.success(mappedModel))
                return
            }
            
            // else load task
            session.dataTask(with: request) { data, responce, error in
                if let error = error {
                    onResponceWasReceived(.failure(error))
                } else if let data = data {
                    do {
                        let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: data)
                        saveResponceToCache(responce, cachedData: data, by: request)
                        onResponceWasReceived(.success(mappedModel))
                    } catch {
                        onResponceWasReceived(.failure(error))
                    }
                } else {
                    onResponceWasReceived(.failure(NetworkTaskError.unknownError))
                }
            }
            .resume()
        } catch {
            onResponceWasReceived(.failure(error))
        }
        
    }
    
}

// MARK: Empty model
extension BaseNetworkTask where Input == EmptyModel {

        func performRequest(_ onResponceWasReceived: @escaping (_ result: Result<AbstractOutput, Error>) -> Void) {
            performRequest(input: EmptyModel(), onResponceWasReceived)
        }
    
}



// MARK: Cache logic
private extension BaseNetworkTask {
    
    func getCachedResponceFromCache(by request: URLRequest) -> CachedURLResponse? {
        return urlCache.cachedResponse(for: request)
    }
    
    func saveResponceToCache(_ response: URLResponse?, cachedData: Data?, by request: URLRequest) {
        guard let response = response, let cachedData = cachedData else {
            return
        }
        let cachedUrlResponce = CachedURLResponse(response: response, data: cachedData)
        urlCache.storeCachedResponse(cachedUrlResponce, for: request)

    }
}

// MARK: Private methods
private extension BaseNetworkTask {
    
    enum NetworkTaskError: Error {
        case urlWasNotFound
        case urlComponentWasNotCreated
        case parametersIsNotValid
        case unknownError
        case notLoggedIn
    }
    
    func getRequest(with parameters: AbstractInput) throws -> URLRequest {
        guard let url = completedURL else {
            throw NetworkTaskError.urlWasNotFound
        }
        
        var request = URLRequest(url: url)
        
        switch method {
        case .get:
            let newUrl = try getUrlWithQueryParameters(for: url, parameters: parameters)
            request = URLRequest(url: newUrl)
        case .post:
            request = URLRequest(url: url)
            request.httpBody = try getParametersForBody(from: parameters)
        }
        
        request.httpMethod = method.method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if isNeedToken {
            request.addValue("Token \(try tokenStorage.getToken().token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }

    func getParametersForBody(from encodableParameters: AbstractInput) throws -> Data {
        return try JSONEncoder().encode(encodableParameters)
    }
    
    func getUrlWithQueryParameters(for url: URL, parameters: AbstractInput) throws -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkTaskError.urlComponentWasNotCreated
        }
        
        let paranetersInDataRepresentation = try JSONEncoder().encode(parameters)
        let parametersInDictionaryRepresentation = try JSONSerialization.jsonObject(with: paranetersInDataRepresentation)
        
        guard let parametersInDictionaryRepresentation = parametersInDictionaryRepresentation as? [String: Any] else {
            throw NetworkTaskError.parametersIsNotValid
        }
        
        let queryItems = parametersInDictionaryRepresentation.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }

        guard let newUrlWithQuerry = urlComponents.url else {
            throw NetworkTaskError.urlWasNotFound
        }
        
        return newUrlWithQuerry
    }
    
}
