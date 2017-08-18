import Foundation
import XCTest
@testable import Redsift

class ProtocolTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testToEncodedMessage(){
    XCTAssertNil(Protocol.toEncodedMessage(data: ["a"], diff: []), "Return of unexpected type should be nil")
   
    func toByte(out: [ComputeResponse] = [], diff: [Double]) -> [UInt8]{
      let stats: [String: Any] = ["result" : diff]
      let m: [String: Any] = ["out" : out, "stats" : stats ]
      return [UInt8](String(describing: m).utf8)
    }
    let emptyMessage = Protocol.toEncodedMessage(data: nil, diff: [])
    XCTAssertEqual(emptyMessage!, toByte(out: [], diff: []), "Return of nil should be nil")
  }

  func testFromEncodedMessage(){
    XCTAssertNil(Protocol.fromEncodedMessage(bytes: nil), "Return of nil should be nil")
    XCTAssertNil(Protocol.fromEncodedMessage(bytes: [UInt8](String(describing: "a").utf8)), "Return of failed parsing should be nil")
  }
}

#if os(Linux)
extension ProtocolTests {
  static var allTests : [(String, (ProtocolTests) -> () throws -> Void)] {
    return [
      // ("testToEncodedMessage", testToEncodedMessage),
      ("testFromEncodedMessage", testFromEncodedMessage)
    ]
  }
}
#endif
