@testable import server
import XCTest

final class serverTests: XCTestCase {
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct
    // results.
    XCTAssertEqual(server().text, "Hello, World!")
  }
}
