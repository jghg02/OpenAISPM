//
//  OpenAIAPI.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 16-03-23.
//

import Foundation

public class OpenAIAPI {
    private let url = "https://api.openai.com/v1/chat/completions"
    private var apiKey: String
    private var model: ChatModel
    private var temperature: Double
    private var stream: Bool
    public var historyMessage = [Message]()
    private let systemMessage: Message
    
    private var headers: [String: String] {
        ["Authorization":"Bearer \(self.apiKey)"]
    }
    
    public init(apiKey: String, model: ChatModel = .chatgpt3_5Turbo, temperature: Double = 0.5, stream: Bool = false) {
        self.apiKey = apiKey
        self.model = model
        self.temperature = temperature
        self.systemMessage = .init(role: Role.system.rawValue, content: "")
        self.stream = stream
    }
    
    public func sendMessage(text: String) async throws -> String {
        switch await makeRequest(with: text) {
        case .success(let data):
            let responseMessage = data.value.choices.first?.message?.content ?? "N/A"
            appendMessageHistory(message: text, responseMessage: responseMessage)
            return responseMessage
        case .failure(let error):
            print(error.errorDescription)
            throw error
        }
    }
    
    // MARK: - Private methods
    
    private func appendMessageHistory(message: String, responseMessage: String) {
        self.historyMessage.append(Message(role: Role.user.rawValue, content: message))
        self.historyMessage.append(Message(role: Role.system.rawValue, content: responseMessage))
    }
    
    private func makeRequest(with text: String) async -> OpenAIClientResult<Response, ErrorResponse> {
        let client = OpenAIClient<Response, ErrorResponse>()
        let request = BodyRequest(url: URL(string: self.url)!, body: setupBody(text: text, stream: self.stream), headers: self.headers)
        
        return await client.request(request)
    }
    
    private func generateMessages(from text: String) -> [Message] {
        var messages = [systemMessage] + historyMessage + [Message(role: Role.user.rawValue, content: text)]
        // Validate the characters for each element into message array
        if messages.contentCount > (4000 * 4) {
            // Delete the first one. No include the system message
            _ = historyMessage.dropFirst()
            messages = generateMessages(from: text)
        }
        return messages
    }
    
    private func setupBody(text: String, stream: Bool) -> Body {
        return Body(model: self.model.rawValue, stream: self.stream, temperature: self.temperature, messages: [Message(role: Role.user.rawValue, content: text)])
        
    }
    
}
