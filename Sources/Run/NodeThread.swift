import Foundation
import Dispatch
import NanoMessage
import Redsift
import Sift

var stdError = FileHandle.standardError
extension FileHandle : TextOutputStream {
  public func write(_ string: String) {
    guard let data = string.data(using: .utf8) else { return }
    self.write(data)
  }
}

class NodeThread {
  public var socket: ReplySocket?
  let threadName: Int
  let addr: String

  public init(name: Int, addr: String){
    self.threadName = name
    self.addr = addr

    guard let url = URL(string: addr) else {
        fatalError("addr is not valid")
    }

    do {
        self.socket = try ReplySocket()
        try self.socket!.setMaximumMessageSize(bytes: -1)
        try self.socket!.setReceiveTimeout(seconds: -1)
        try self.socket!.setSendTimeout(seconds: -1)

        let endPoint: EndPoint = try self.socket!.createEndPoint(url: url, type: .Bind, name: "reply end-point")
        print(endPoint)

        while (true) {
            print("waiting for a request...")

            let sent = try self.socket!.receiveMessage(receiveMode: .Blocking, sendMode: .Blocking) { received in
                print("received \(received)")
                let req = [UInt8](received.message.data)
                guard let computeReq: ComputeRequest = Protocol.fromEncodedMessage(bytes: req) else {
                  return Message(value: Protocol.toErrorBytes(message: "check for errors in node: \(self.threadName)", stack: ""))
                }

                let computeF = Sift.computes[self.threadName]

                let start = DispatchTime.now().uptimeNanoseconds
                let resp = computeF(computeReq)
                let end = DispatchTime.now().uptimeNanoseconds
                let t = Double(end - start) / pow(10, 9)
                var diff: [Double] = [floor(t)]
                diff.append((t - diff[0]) * pow(10, 9))
                print("diff info: \(diff)")

                guard let reply = Protocol.toEncodedMessage(data: resp, diff: diff) else {
                  return Message(value: Protocol.toErrorBytes(message: "check for errors in node: \(self.threadName)", stack: ""))
                }

                return Message(value: reply)
            }

            print("and sent \(sent)")
        }
        print("Thread \(self.threadName) exiting")
    } catch let error as NanoMessageError {
        print(error, to: &stdError)
        exit(1)
    } catch {
        print("an unexpected error '\(error)' has occured in the library libNanoMessage.", to: &stdError)
        exit(1)
    }
  }
}
