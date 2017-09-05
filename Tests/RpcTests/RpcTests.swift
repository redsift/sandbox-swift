import Foundation
import XCTest
@testable import Rpc

class RpcTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testRequestFromJSONfunc() {
    let reqpath = URL(fileURLWithPath: "TestFixtures/rpc/request.json")
    var jsonString: String = ""
    do{
      jsonString = try String(contentsOf: reqpath, encoding: .utf8)
    }catch{
      XCTFail("Error: Could not parse request")
    }
    let req: Request = Rpc.Request(JSONString: jsonString)!
    XCTAssertEqual(req.remoteAddr, "faraway.com")
    XCTAssertEqual(req.method, "GET")
    XCTAssertEqual(req.requestUri, "/simple")
    guard let header = req.header else {
      XCTFail("Unwrapping header failed")
      return
    }
    guard let contentType = header["Content-Type"] else {
      XCTFail("There is no Content-Type header")
      return
    }
    XCTAssertEqual(contentType[0], "text/html; charset=utf-8")
    guard let body = req.body else {
      XCTFail("Request has no body")
      return
    }
    XCTAssertEqual(String(data: body, encoding: .utf8), "payload")
  }

  func testResponseToStringfunc() {
    let reppath = URL(fileURLWithPath: "TestFixtures/rpc/response.txt")
    var txtString: String = ""
    do{
      txtString = try String(contentsOf: reppath, encoding: .utf8)
    }catch{
      XCTFail("Error: Could not parse response")
    }
    let rep: Response = Rpc.Response(200, ["Content-Type":["text/html; charset=utf-8"]], "payload".data(using: .utf8))
    print("Following string should look similar:")
    print("Expected: \(txtString)")
    print("Produced: \(String(describing: rep.toJSONString()!))")
    XCTAssertEqual(txtString.characters.count, rep.toJSONString()!.characters.count) // loose test
  }
}


#if os(Linux)
extension RpcTests {
  static var allTests : [(String, (RpcTests) -> () throws -> Void)] {
    return [
      ("testRequestFromJSONfunc", testRequestFromJSONfunc),
      ("testResponseToStringfunc", testResponseToStringfunc)
    ]
  }
}
#endif
