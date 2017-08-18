import Foundation
import XCTest
@testable import Redsift

class RedsiftInitTests: XCTestCase {
  override func setUp() {
    super.setUp()
    setenv("SIFT_JSON", "TestFixtures/sift.json", 1) //key, value, overwrite?
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testInitfunc() {
    let i1 = Init(args: [])
    XCTAssertNil(i1) 
  }
}


#if os(Linux)
extension RedsiftInitTests {
  static var allTests : [(String, (RedsiftInitTests) -> () throws -> Void)] {
    return [
      ("testInitfunc", testInitfunc)
    ]
  }
}
#endif
