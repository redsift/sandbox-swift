import Foundation
import ObjectMapper

public struct ComputeRequest: Mappable {
  public var `in`: InputData?
  public var with: InputData?
  public var query: [String]?
  public var lookup: [LookupData]?

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

public struct InputData: Mappable {
  public var bucket: String?
  public var data: [DataQuantum]?

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

public struct LookupData: Mappable {
  public var bucket: String?
  public var data: DataQuantum?

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

public struct DataQuantum: Mappable {
  public var key: String?
  public var value: Data?
  public var epoch: Int? //platform specific
  public var generation: Int?

  init?(map: Map){ }
  mutating func mapping(map: Map) {
    key <- map["key"]
    value <- (map["value"], DataTransform())
    epoch <- map["epoch"]
    generation <- map["generation"]
  }
}

extension DataQuantum: CustomStringConvertible {
    var description: String {
        var svalue: String?
        if let v = value {
            svalue = String(bytes: v, encoding: .utf8)
        }
        return "[key: \(String(describing: key)), value: \(String(describing: svalue)), epoch: \(String(describing: epoch)), generation: \(String(describing: generation))]"
    }
}
