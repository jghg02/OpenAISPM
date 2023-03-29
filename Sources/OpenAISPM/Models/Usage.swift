//
//  Usage.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 15-03-23.
//

struct Usage: Decodable {
    let promptTokens: Int?
    let completionTokens: Int?
    let totalTokens: Int?
}
