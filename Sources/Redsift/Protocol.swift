import Foundation

public class Protocol {
  func encodeValue() -> ComputeResponse? {
    return nil
  }
  func toEncodedMessage(data: Any?, diff: [Double]) -> [UInt8]{
    var out: [ComputeResponse] = []
    if data != nil {
      // attempt to unwrap only for non nil values
      switch(String(describing: type(of: data!))) {
        case ComputeResponse.self :
          // might need casting
          out.append(encodeValue(data))
        case [ComputeResponse].self :
          for item in data {
            out.append(encodeValue(data))
          }
      }
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
  func toErrorBytes(message: String, stack: String) -> [UInt8]{
    let err: [String: String] = [
      "message" : message,
      "stack" : stack
    ]
    let m: [String: Any] = [
      "error" : err
    ]
    return [UInt8](String(describing: m).utf8)
  }
  func fromEncodedMessage(b: [UInt8]) -> ComputeRequest? {
     guard let jsonString = String(bytes: b, encoding: .utf8) else{
      print("Could not decode request")
      return nil
    }
    return ComputeRequest(JSONString: jsonString)
  }
}