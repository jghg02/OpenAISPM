//
//  OpenAIClient.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 16-03-23.
//

import Foundation

public typealias OpenAIClientResult<N, E> = Result<APIResponse<N>, HTTPError<E>>
    where N: Decodable, E: LocalizedError & Decodable

/// This is the struct to implement the request
class OpenAIClient<N, E> where N: Decodable, E: LocalizedError & Decodable {
    
    /// client a session
    private let requestLoader: RequestLoader
    
    /// Init method to inject any implementation of the RequestLoader protocol
    /// - Parameter requestLoader: This is the conforming RequestLoader protocol cobject as the default parameter will instantiate an URLSession
    init(requestLoader: RequestLoader = OpenAIConfig.requestLoader) {
        self.requestLoader = requestLoader
    }

    /// Performs a API request
    /// - Parameters:
    ///   - request:All config to use in a request
    func request(_ request: APIRequest) async -> OpenAIClientResult<N, E> {
        await self.request(request.asURLRequest)
    }

    /// Performs a API request which is called by any service request class.
    /// It also performs an additional task of validating the auth token and refreshing if necessary
    ///
    /// - Parameters:
    ///   - request: APIModelType which contains the info about api path, header & http method type.
    func request(_ request: URLRequest) async -> OpenAIClientResult<N, E> {
        do {
            let (data, response) = try await requestLoader.request(request)
            return handleResponse(response, with: data)
        } catch {
            return .failure(.failedRequest(error as? URLError))
        }
    }

    private func handleResponse<N>(_ response: URLResponse, with data: Data) -> OpenAIClientResult<N, E> {
        guard let response = response as? HTTPURLResponse
        else { return .failure(.failedRequest(nil)) }

        if (200 ..< 300).contains(response.statusCode) {
            return handleSuccess(data, headers: response.allHeaderFields)
        } else {
            return handleFailure(data, statusCode: response.statusCode)
        }
    }

    private func handleSuccess<N, E>(_ data: Data, headers: [AnyHashable: Any]) -> OpenAIClientResult<N, E> {
        if let value: N = parse(data) {
            return .success(APIResponse(headers: headers, value: value))
        } else {
            return .failure(.responseTypeMismatch)
        }
    }

    private func handleFailure<N, E>(_ data: Data, statusCode: Int) -> OpenAIClientResult<N, E> {
        if let error: E = parse(data) {
            return .failure(.invalidRequest(error))
        } else {
            return .failure(.invalidResponse(statusCode))
        }
    }
    
    /// Method to parser the data from services
    /// - Parameter data: Data
    /// - Returns: Struc/Class with al information decoded
    private func parse<N: Decodable>(_ data: Data?) -> N? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = OpenAIConfig.keyDecodingStrategy
        return try? decoder.decode(N.self, from: data)
    }
}


