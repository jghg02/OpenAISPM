//
//  OpenAIConfig.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 16-03-23.
//

import Foundation

public enum OpenAIConfig {
    static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    static var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase
    static var requestLoader: RequestLoader = URLSession.shared

    static func resetToDefaults() {
        keyDecodingStrategy = .convertFromSnakeCase
        keyEncodingStrategy = .convertToSnakeCase
        requestLoader = URLSession.shared
    }
}
