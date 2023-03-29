//
//  JSONDecoder+Extension.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 16-03-23.
//

import Foundation

extension JSONDecoder {
    static var convertingKeysFromSnakeCase: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
