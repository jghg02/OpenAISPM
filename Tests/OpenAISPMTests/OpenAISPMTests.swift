import XCTest
@testable import OpenAISPM

final class OpenAISPMTests: XCTestCase {
    func testSendMessage() async {
#warning("You need provide you API KEY")
        let openAIAPI = OpenAIAPI(apiKey: "YOUR_API_KEY")
        
        let result = try! await openAIAPI.sendMessage(text: "Capital of Venezuela")
        
        XCTAssertEqual(result, "The capital of Venezuela is Caracas.")
    }
    
    func testSendTwoorMoreMessage() async {
        #warning("You need provide you API KEY")
        let openAIAPI = OpenAIAPI(apiKey: "YOUR_API_KEY")
        
        let result = try! await openAIAPI.sendMessage(text: "Capital of Venezuela")
        let result2 = try! await openAIAPI.sendMessage(text: "Capital of Canada")
        
        XCTAssertEqual(result, "The capital of Venezuela is Caracas.")
        XCTAssertEqual(result2, "Ottawa")
        XCTAssertFalse(openAIAPI.historyMessage.isEmpty)
        // Is 4 because for each message you add into historyMessage one element with rol User and
        // you expected two response for System role each response corresponding for each message you sent
        XCTAssertEqual(openAIAPI.historyMessage.count, 4)
    }
    
}
