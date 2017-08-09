import Foundation
import ObjectMapper

public struct ComputeRequest: Mappable {
  var `in`: InputData?
  var with: InputData?
  var query: [String]?
  var lookup: [LookupData]?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    `in` <- map["in"]
    with <- map["with"]
    query <- map["query"]
    lookup <- map["lookup"]
  }
}

extension ComputeRequest: CustomStringConvertible {
  public var description: String{
    return "[in: \(String(describing: `in`)), with: \(String(describing: with)), query: \(String(describing: query)), lookup: \(String(describing: lookup))]"
  }
}

struct InputData: Mappable {
  var bucket: String?
  var data: [Data]?

  init?(map: Map){ }
  mutating func mapping(map: Map) {
    bucket <- map["bucket"]
    data <- map["data"]
  }
}

extension InputData: CustomStringConvertible {
  var description: String{
    return "[bucket: \(String(describing: bucket)), data: \(String(describing: data))]"
  }
}

struct LookupData: Mappable {
  var bucket: String?
  var data: Data?

  init?(map: Map){ }
  mutating func mapping(map: Map) {
    bucket <- map["bucket"]
    data <- map["data"]
  }
}

extension LookupData: CustomStringConvertible {
  var description: String{
    return "[bucket: \(String(describing: bucket)), data: \(String(describing: data))]"
  }
}

struct Data: Mappable {
  var key: String?
  var value: [UInt8]?
  var epoch: Int? //platform specific
  var generation: Int?

  init?(map: Map){ }
  mutating func mapping(map: Map) {
    key <- map["key"]
    value <- map["value"]
    epoch <- map["epoch"]
    generation <- map["generation"]
  }
}

extension Data: CustomStringConvertible {
    var description: String {
        var svalue: String?
        if let v = value {
            svalue = String(bytes: v, encoding: .utf8)
        }
        return "[key: \(String(describing: key)), value: \(String(describing: svalue)), epoch: \(String(describing: epoch)), generation: \(String(describing: generation))]"
    }
}
