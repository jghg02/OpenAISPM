//
//  BodyRequest.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 16-03-23.
//

import Foundation

public class BodyRequest<N: Encodable>: APIRequest {
    public init(url: URL, method: Method  = .POST, body: N, headers: Headers = [:]) {
        self.body = body
        super.init(url: url, method: method, headers: headers)
    }
    
    override func addToRequest(_ request: inout URLRequest) {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = OpenAIConfig.keyEncodingStrategy
        request.httpBody = try? encoder.encode(body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    private let body: N
    
}
