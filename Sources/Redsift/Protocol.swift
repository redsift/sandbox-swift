import Foundation

class Protocol {
  static func encodeValue(data: ComputeResponse) -> ComputeResponse {
    var rdata = data
    guard let valObj = rdata.value else {
      return rdata
    }
    
    if valObj is [UInt8] { // no-op
    }
    // TODO: this probably not needed
    // else if valObj is String {
    //   print("This is the String type \(String(describing: valObj))")
    //   // TODO: might need to treat this as a special case for JSON encoded 
    //   rdata.value = [UInt8](String(describing: valObj).utf8)
    // }
    else{
      rdata.value = [UInt8](String(describing: valObj).utf8)
    }
    return rdata
  }

  static func toEncodedMessage(data: Any?, diff: [Double]) -> [UInt8]?{
    var out: [ComputeResponse] = []
    if data == nil {
    // attempt to unwrap only for non nil values
    }else if data! is ComputeResponse {
      // might need casting
      out.append(encodeValue(data: data as! ComputeResponse))
    }else if data! is [ComputeResponse] {
      for item in data as! [ComputeResponse] {
        out.append(encodeValue(data: item))
      }
    }else{
      print("node implementation has to return ComputeResponse, Array<ComputeResponse> or nil")
      return nil
    }

    let stats: [String: Any] = [
      "result" : diff
    ]
    let m: [String: Any] = [
      "out" : out,
      "stats" : stats
    ]
    return [UInt8](String(describing: m).utf8)
  }

  static func toErrorBytes(message: String, stack: String) -> [UInt8]{
    let err: [String: String] = [
      "message" : message,
      "stack" : stack
    ]
    let m: [String: Any] = [
      "error" : err
    ]
    return [UInt8](String(describing: m).utf8)
  }

  static func fromEncodedMessage(b: [UInt8]) -> ComputeRequest? {
     guard let jsonString = String(bytes: b, encoding: .utf8) else{
      print("Could not decode request")
      return nil
    }
    return ComputeRequest(JSONString: jsonString)
  }
}
