import Foundation
import ObjectMapper

struct ProtocolMessage: Mappable {
  var out: [ComputeResponseInternal] = []
  var stats: [String: [Double]] = [:]

  init(_ o: [ComputeResponseInternal], _ s: [String: [Double]]){
    self.out = o
    self.stats = s
  }
  init?(map: Map){ }
  mutating func mapping(map: Map) {
    out <- map["out"]
    stats <- map["stats"]
  }
}

struct ProtocolError: Mappable {
  var error: [String: String] = [:]

  init(_ e: [String: String]){
    self.error = e
  }
  init?(map: Map){ }
  mutating func mapping(map: Map) {
    error <- map["error"]
  }
}

public class Protocol {
  public static func toEncodedMessage(d: Any?, diff: [Double]) -> [UInt8]?{
    var out: [ComputeResponseInternal] = []
    guard let data = d else {
      return nil
    }

    if data is ComputeResponse {
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
    guard let t = Mapper(shouldIncludeNilValues: true).toJSONString(m) else {
      print("stringifying ProtocolMessage failed")
      return nil
    }
    return [UInt8](t.utf8)
  }

  public static func toErrorBytes(message: String, stack: String) -> [UInt8]{
    let m = ProtocolError(["message": message, "stack": stack])
    print("Error \(m)")
    guard let t = Mapper(shouldIncludeNilValues: true).toJSONString(m) else {
      print("stringifying ProtocolError failed")
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
