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
    typealias Input = AbstractInput
    typealias Output = AbstractOutput
    
    var baseURL: URL? {
       URL(string: "https://pictures.chronicker.fun/api")
    }
    
    let path: String
    let method: NetworkMethod
    let session: URLSession = URLSession(configuration: .default)
    
    // MARK: Initialization
    
    init(method: NetworkMethod, path: String ) {
        self.path = path
        // ПОПРАВИТЬ!
        self.method = method
    }
    
    // MARK: Methods
    
    func performRequest(_ input: AbstractInput, _ onResponceWasReceived: (Result<AbstractOutput, Error>) -> Void) {
        session.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
    }
    
}


private extension BaseNetworkTask {
    
    enum NetworkTaskError: Error {
        case urlWasNotFound
        case urlComponent
        case parametersIsNotValid
    }
    
    func getRequest() throws -> URLRequest {
        guard let url = completedURL else {
            throw NetworkTaskError.urlWasNotFound
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = method.method
        
        let newURL: URL
        switch method {
        case .get:
            newURL = try getUrlWithQueryParameters(for: url, parameters: parameters)
        case .post:
            newURL = url
            request.httpBody = try getParametersForBody(from: parameters)
        }
    }
    
    //func getParametersForBody(from encoda)
    
    func getUrlWithQueryParameters(for url: URL, parameters: AbstractInput) throws -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkTaskError.urlComponent
        }
        let paranetersInDataRepresentation = try JSONEncoder().encode(parameters)
        let parametersInDictionaryRepresentation = try JSONSerialization.jsonObject(with: paranetersInDataRepresentation)
        
        guard let parametersInDictionaryRepresentation = parametersInDictionaryRepresentation as? [String: Any] else {
            throw NetworkTaskError.parametersIsNotValid
        }
        
        let queryItems = parametersInDictionaryRepresentation.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        
        urlComponents.queryItems = queryItems
        
        guard let newUrlWithQuerry = urlComponents.url else {
            throw NetworkTaskError.urlWasNotFound
        }
        
        return newUrlWithQuerry
    }
    
    
}
