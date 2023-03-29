import XCTest
@testable import OpenAISPM

final class OpenAISPMTests: XCTestCase {
    func testSendMessage() async {
        let openAIAPI = OpenAIAPI(apiKey: "YOUR_API_KEY")
        let result = try! await openAIAPI.sendMessage(text: "Capital of Venezuela")
        XCTAssertEqual(result, "The capital of Venezuela is Caracas.")
    }
}
