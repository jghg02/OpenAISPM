//
//  BodyRequestTest.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 31-03-23.
//

@testable import OpenAISPM
import XCTest


final class BodyRequestTest: XCTestCase {

    func test_init_encodedBody() throws {
        let request = BodyRequest(url: URL.test, body: TestObject())
        let urlRequest = request.asURLRequest
        
        let data = try XCTUnwrap(urlRequest.httpBody)
        let object = try? JSONDecoder.convertingKeysFromSnakeCase.decode(TestObject.self, from: data)
        XCTAssertEqual(object, TestObject())
    }
    
    func test_init_ContentTypeHeaderJSON() {
        let request = BodyRequest(url: URL.test, body: TestObject())
        let urlRequest = request.asURLRequest
        
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_headers() {
        let request = BodyRequest(url: URL.test, body: TestObject())
        let urlRequest = request.asURLRequest
        
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields)
    }
    
    func test_setsHeaderFields() {
        let request = BodyRequest(
            url: URL.test,
            body: TestObject(),
            headers: ["VALUE": "THE-custom-value---"]
        )

        let urlRequest = request.asURLRequest
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "VALUE"), "THE-custom-value---")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func test_useSnakeCase() throws {
        OpenAIConfig.keyEncodingStrategy = .convertToSnakeCase
        let request = BodyRequest(url: URL.test, body: TestObject())
        let urlRequest = request.asURLRequest
        let data = try XCTUnwrap(urlRequest.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: data, options: []) as? [String: String])
        
        XCTAssertEqual(json["last_name"], "Hernandez")
    }

}

// MARK: - Helpers

/// Body
struct TestObject: Codable, Equatable {
    let name: String
    let lastName: String

    init(name: String = "Josue", lastName: String = "Hernandez") {
        self.name = name
        self.lastName = lastName
    }
}

struct TestError: LocalizedError, Codable, Equatable {
    let message: String
}

// MARK: - Helper JSONDecoder
extension JSONDecoder {
    static var convertingKeysFromSnakeCase: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
