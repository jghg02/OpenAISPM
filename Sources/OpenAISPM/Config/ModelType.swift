//
//  ModelType.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 20-03-23.
//

import Foundation


/// A set of models that can understand and generate natural language
///
/// [GPT-3 Models OpenAI API Docs](https://beta.openai.com/docs/models/gpt-3)
public enum OpenAIModel: String {
    case ada = "text-davinci-002"
    case babbage = "text-babbage-001"
    case curie = "text-curie-001"
    case davinci = "text-davinci-001"
    case davinciInstructBeta = "davinci-instruct-beta-001"
    case curieInstructBeta = "curie-instruct-beta-001"
}

/// A set of models for the new chat completions
/// You can read the [API Docs](https://platform.openai.com/docs/api-reference/models/list)
public enum ChatModel: String {
        
    /// Most capable GPT-3.5 model and optimized for chat at 1/10th the cost of text-davinci-003. Will be updated with our latest model iteration.
    /// > Model Name: gpt-3.5-turbo
    case chatgpt3_5Turbo = "gpt-3.5-turbo"
}
