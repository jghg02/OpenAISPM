//
//  Body.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 15-03-23.
//

/// This is the structure to represent the Request Body.
/// For more details you could see the all documentacion about it her:
/// https://platform.openai.com/docs/api-reference/completions/create
struct Body: Codable {
    
    /// Model is required and represent the ID of the model to use.
    /// You can use the List models https://platform.openai.com/docs/api-reference/models/list
    /// API to see all of your available models, or see our Model overview for descriptions of them.
    let model: String
    
    /// Stream is an optional.
    var stream: Bool
    
    /// Temperature is optional.
    /// What sampling temperature to use,
    /// between 0 and 2.
    /// Higher values like 0.8 will make the output more random,
    /// while lower values like 0.2 will make it more focused and deterministic.
    let temperature: Double
    
    /// Message is an array and is requiered
    /// The messages to generate chat completions for, in the chat format.
    let messages: [Message]
    
}
