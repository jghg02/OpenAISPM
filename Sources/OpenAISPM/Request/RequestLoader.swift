//
//  RequestLoader.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 16-03-23.
//

import Foundation

/// Protocol
public protocol RequestLoader {
    func request(_ request: URLRequest) async throws -> (Data, URLResponse)
}


/// Helper class to prepare request(adding headers & clubbing base URL) & perform API request.
extension URLSession: RequestLoader {
    public func request(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request)
    }
}


extension URLSession {
    
    /// Performs a API request which is called by any service request class.
    /// It also performs an additional task of validating the auth token and refreshing if necessary
    ///
    /// - Parameters:
    ///   - URL: URL
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
    
}
