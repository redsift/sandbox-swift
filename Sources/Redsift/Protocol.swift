import Foundation
import ObjectMapper

struct ProtocolMessage: Mappable {
  var out: [ComputeResponseInternal] = []
  var stats: [String: [Double]] = [:]
  var error: [String: String]?

  init(_ o: [ComputeResponseInternal], _ s: [String: [Double]]){
    self.out = o
    self.stats = s
  }

  init(_ e: [String: String]){
    self.error = e
  }

  init?(map: Map){ }
  mutating func mapping(map: Map) {
    out <- map["out"]
    stats <- map["stats"]
    error <- map["error"]
  }
}

public class Protocol {
  public static func toEncodedMessage(data: Any?, diff: [Double]) -> [UInt8]?{
    var out: [ComputeResponseInternal] = []
    if data == nil {

    }else if data is ComputeResponse {
      out.append(ComputeResponseInternal(cr: data as! ComputeResponse))
    }else if data is [ComputeResponse] {
      for item in data as! [ComputeResponse] {
        out.append(ComputeResponseInternal(cr: item))
      }
    }else{
      print("node implementation has to return ComputeResponse, Array<ComputeResponse> or nil")
      return nil
    }

    let m = ProtocolMessage(out, ["result": diff])
    guard let t = m.toJSONString() else {
      print("stringifying ProtocolMessage failed")
      return nil
    }
    return [UInt8](t.utf8)
  }

  public static func toErrorBytes(message: String, stack: String) -> [UInt8]{
    print("toErrorBytes: message:\(message), stack: \(stack)")
    let m = ProtocolMessage(["message": message, "stack": stack])
    guard let t = m.toJSONString() else {
      print("stringifying ProtocolMessage failed")
      return []
    }
    return [UInt8](t.utf8)
  }

  public static func fromEncodedMessage(bytes: [UInt8]?) -> ComputeRequest? {
     guard let b = bytes,
      let jsonString = String(bytes: b, encoding: .utf8) else{
      print("Error: Could not decode request")
      return nil
    }
    return ComputeRequest(JSONString: jsonString)
  }
}
