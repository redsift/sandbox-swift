import Foundation
import Dispatch
import XCTest
import NanoMessage
@testable import Redsift

func shellUtil(_ launchPath: String,_ arguments: [String]) -> Process{
  let task = Process()
  task.launchPath = launchPath
  task.arguments = arguments

  task.standardOutput = FileHandle.standardOutput
  task.standardError = FileHandle.standardError
  task.launch()

  return task
}

func sendMessage(urlToUse: String, message: Message) -> Any?{
  guard let url = URL(string: urlToUse) else {
      fatalError("url is not valid")
  }

  do {
      let node = try RequestSocket()
      let endPoint: EndPoint = try node.createEndPoint(url: url, type: .Connect, name: "request end-point")
      print(endPoint)
      
      let timeout = TimeInterval(seconds: 10)
      let received = try node.sendMessage(message, sendTimeout: timeout, receiveTimeout: timeout) { sent in
          print("testSendMessage: sent: \(sent.message.string)")
      }

      print("testSendMessage: received: \(received.message.string)")
      do {
          let a = try JSONSerialization.jsonObject(with: received.message.data) as! [String: Any]
          print("this is the encoded back", a)
          return a["out"]
      }catch {
          print("serialization failed: \(error)")
          return nil
      }

  } catch let error as NanoMessageError {
      print("NanoMessageError: \(error)")
  } catch {
      print("an unexpected error '\(error)' has occured in the library libNanoMessage.")
  }
  return nil
}



class RunTests: XCTestCase {
  static var pids: [Int32] = []
  let cla = ["./.build/debug/Run", "0", "1", "2"]

  override class func setUp() {
    super.setUp()
    let cla = ["./.build/debug/Run", "0", "1", "2"]
    setenv("SIFT_ROOT", "/tmp/sandbox/TestFixtures/sift", 1) //key, value, overwrite?
    // Install the nodes
    _ = shellUtil("./.build/debug/Install", Array(cla[1..<cla.count]))
    sleep(1)
    DispatchQueue.global().async{
      let t = shellUtil(cla[0], Array(cla[1..<cla.count]))
      self.pids.append(t.processIdentifier)
    }
    sleep(1)
  }

  override class func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    for p in self.pids{
      print("killing PID: \(p)")
      _ = shellUtil("/bin/kill", ["-9", "\(p)"])
    }
    super.tearDown()
  }

  func testEmptyNodefunc() {
    let info = Init(args: self.cla)
    XCTAssertNotNil(info)

    let m = Message(value: "{\"in\":{}}")
    let url = "ipc://\(info!.IPC_ROOT)/\(self.cla[1]).sock"
    guard let nodeResponse = sendMessage(urlToUse: url, message: m) else {
      XCTFail("sending message a failed")
      return
    }
    XCTAssertEqual(nodeResponse as! [String], [String]())
  }

  func testComputeResponseNodefunc() {
    let info = Init(args: self.cla)
    XCTAssertNotNil(info)

    let m = Message(value: "{\"in\":{}}")
    let url = "ipc://\(info!.IPC_ROOT)/\(self.cla[2]).sock"
    guard let nodeResponse = sendMessage(urlToUse: url, message: m) else {
      XCTFail("sending message a failed")
      return
    }
    print(nodeResponse)
  }

  func testWrongReturnNodefunc() {
    let info = Init(args: self.cla)
    XCTAssertNotNil(info)

    let m = Message(value: "{\"in\":{}}")
    let url = "ipc://\(info!.IPC_ROOT)/\(self.cla[3]).sock"
    XCTAssertNil(sendMessage(urlToUse: url, message: m))
  }
  
}


#if os(Linux)
extension RunTests {
  static var allTests : [(String, (RunTests) -> () throws -> Void)] {
    return [
      ("testEmptyNodefunc", testEmptyNodefunc),
      ("testComputeResponseNodefunc", testComputeResponseNodefunc),
      ("testWrongReturnNodefunc", testWrongReturnNodefunc)
    ]
  }
}
#endif