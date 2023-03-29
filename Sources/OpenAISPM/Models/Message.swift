//
//  Message.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 15-03-23.
//

/// This the structure where put the information to send to OpenAI API
struct Message: Codable {
    let role: String
    
    /// Content is required
    let content: String
}
