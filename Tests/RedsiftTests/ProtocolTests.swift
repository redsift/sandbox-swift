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
  let jsonString = "{\"name\":\"something\"}";
  func testEncodeValuefunc() {
    let cr1 = ComputeResponse(name: "something", key: "key")
    let ec1 = Protocol.encodeValue(data: cr1)
    XCTAssertNil(ec1.value)

    let a = String(describing: "a").utf8
    let cr2 = ComputeResponse(value: [UInt8](a))
    let ec2 = Protocol.encodeValue(data: cr2)
    XCTAssertEqual(ec2.value as! [UInt8], [UInt8](a), "Should be a no-op")

    let cr3 = ComputeResponse(value: ["a"])
    let ec3 = Protocol.encodeValue(data: cr3)
    XCTAssertEqual(ec3.value as! [UInt8], [UInt8](String(describing: ["a"]).utf8), "Type Any should be a encoded as [UInt8]")
  
    let cr4 = ComputeResponse(value: "a")
    let ec4 = Protocol.encodeValue(data: cr4)
    XCTAssertEqual(ec4.value as! [UInt8], [UInt8](String(describing: "a").utf8), "Type String should be a encoded as [UInt8]")
  
    let cr5 = ComputeResponse(value: cr4.toJSONString())
    let ec5 = Protocol.encodeValue(data: cr5)
    XCTAssertEqual(ec5.value as! [UInt8], [UInt8]((cr4.toJSONString()!).utf8), "Type String from JSON should be a encoded as [UInt8]")
  }
}

#if os(Linux)
extension ProtocolTests {
  static var allTests : [(String, (ProtocolTests) -> () throws -> Void)] {
    return [
      ("testEncodeValuefunc", testEncodeValuefunc)
    ]
  }
}
#endif
