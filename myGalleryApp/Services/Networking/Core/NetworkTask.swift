//
//  NetworkTask.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 08.08.2022.
//

import Foundation

protocol NetworkTask {
    
    associatedtype Input: Encodable
    associatedtype Output: Decodable
    
    var baseURL: URL? { get }
    var path: String { get }
    var completedURL: URL? { get }
    var method: NetworkMethod { get }
    
    func performRequest(_ input: Input,
                        _ onResponceWasReceived: (_ result: Result<Output, Error>) -> Void
                        )
    
}

extension NetworkTask {
    var completedURL: URL? {
        baseURL?.appendingPathComponent(path)
    }
}
