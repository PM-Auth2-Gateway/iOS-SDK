import XCTest
@testable import AuthPM

final class AuthPMTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AuthPM().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
