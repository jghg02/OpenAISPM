//
//  Choice.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 15-03-23.
//

struct Choice: Decodable {
    let message: Message?
    let delta: Delta?
    let index: Int?
    let finishReason: String?
}
