//
//  Error.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 15-03-23.
//

import Foundation

public struct ErrorResponse: LocalizedError, Decodable {
    let error: Error
    public var errorDescription: String? { error.message }
}

struct Error: Decodable {
    let message: String
    let type: String?
}
