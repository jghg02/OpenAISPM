//
//  Response.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 16-03-23.
//

struct Response: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let usage: Usage?
    let choices: [Choice]
}
