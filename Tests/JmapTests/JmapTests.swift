import Foundation
import XCTest
@testable import Jmap

class JmapTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testParsingfunc() {
    let email1path = URL(fileURLWithPath: "TestFixtures/emails/email1.msg")
    var jsonString: String = ""
    do{
      jsonString = try String(contentsOf: email1path, encoding: .utf8)
    }catch{
      XCTFail("Error: Could not parse email")
    }
    let jm: Message = Jmap.Message(JSONString: jsonString)!
    XCTAssertEqual(jm.user, "christos@redsift.io")
    XCTAssertEqual(jm.mailboxIds, ["inbox","important"])
    XCTAssertEqual(jm.isUnread, false)
    XCTAssertEqual(jm.isAnswered, true)
    XCTAssertEqual(jm.from!.name, "Rois Ni Thuama")
    XCTAssertEqual(jm.from!.email, "rois@redsift.io")
    XCTAssertEqual(jm.headers["Delivered-To"], "christos@redsift.io")
    print("This is size: \(String(describing: jm.size))")
    // XCTAssertEqual(jm.size, 615124) //TODO: this should pass
  }
}


#if os(Linux)
extension JmapTests {
  static var allTests : [(String, (JmapTests) -> () throws -> Void)] {
    return [
      ("testParsingfunc", testParsingfunc)
    ]
  }
}
#endif
