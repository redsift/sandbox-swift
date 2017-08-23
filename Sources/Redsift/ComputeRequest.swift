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
    let _e: Any = "nil"
    return "[in: \(String(describing: `in` ?? _e)), with: \(String(describing: with ?? _e)), query: \(String(describing: query ?? _e)), lookup: \(String(describing: lookup ?? _e))]"
  }
}

public struct InputData: Mappable {
  public var bucket: String?
  public var data: [DataQuantum]?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    bucket <- map["bucket"]
    data <- map["data"]
  }
}

extension InputData: CustomStringConvertible {
  public var description: String{
    let _e: Any = "nil"
    return "[bucket: \(String(describing: bucket ?? _e)), data: \(String(describing: data ?? _e))]"
  }
}

public struct LookupData: Mappable {
  public var bucket: String?
  public var data: DataQuantum?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    bucket <- map["bucket"]
    data <- map["data"]
  }
}

extension LookupData: CustomStringConvertible {
  public var description: String{
    let _e: Any = "nil"
    return "[bucket: \(String(describing: bucket ?? _e)), data: \(String(describing: data ?? _e))]"
  }
}

public struct DataQuantum: Mappable {
  public var key: String?
  public var value: Data?
  public var epoch: Int? //platform specific
  public var generation: Int?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    key <- map["key"]
    value <- (map["value"], DataTransform())
    epoch <- map["epoch"]
    generation <- map["generation"]
  }
}

extension DataQuantum: CustomStringConvertible {
    public var description: String {
      let _e: Any = "nil"
      var svalue: String?
      if let v = value {
          svalue = String(data: v, encoding: .utf8)
      }
      return "[key: \(String(describing: key ?? _e)), value: \(String(describing: svalue ?? _e)), epoch: \(String(describing: epoch ?? _e)), generation: \(String(describing: generation ?? _e))]"
    }
}
