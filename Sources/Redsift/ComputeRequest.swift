import Foundation
import ObjectMapper

public struct ComputeRequest: Mappable {
  public var `in`: InputData = InputData()
  public var with: InputData?
  public var query: [String]?
  public var lookup: [LookupData]?
  public var `get`: [GetData]?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    `in` <- map["in"]
    with <- map["with"]
    query <- map["query"]
    lookup <- map["lookup"]
    `get` <- map["get"]
  }
}

extension ComputeRequest: CustomStringConvertible {
  public var description: String{
    let _e: Any = "nil"
    return "[in: \(String(describing: `in`)), with: \(String(describing: with ?? _e)), query: \(String(describing: query ?? _e)), lookup: \(String(describing: lookup ?? _e)), get: \(String(describing: `get` ?? _e))]"
  }
}

public struct InputData: Mappable {
  public var bucket: String = ""
  public var data: [DataQuantum] = []

  public init(){}

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    bucket <- map["bucket"]
    data <- map["data"]
  }
}

extension InputData: CustomStringConvertible {
  public var description: String{
    return "[bucket: \(bucket), data: \(String(describing: data))]"
  }
}

public struct LookupData: Mappable {
  public var bucket: String = ""
  public var data = DataQuantum()

  public init() {}


  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    bucket <- map["bucket"]
    data <- map["data"]
  }
}

extension LookupData: CustomStringConvertible {
  public var description: String{
    return "[bucket: \(bucket), data: \(String(describing: data))]"
  }
}

public struct GetData: Mappable {
  public var bucket: String = ""
  public var key: String = ""
  public var data: [DataQuantum] = []

  public init() {}


  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    bucket <- map["bucket"]
    key <- map["key"]
    data <- map["data"]
  }
}

extension GetData: CustomStringConvertible {
  public var description: String{
    return "[bucket: \(bucket), key: \(key), data: \(String(describing: data))]"
  }
}

public struct DataQuantum: Mappable {
  public var key: String = ""
  public var value: Data?
  public var epoch: Int = 0 //platform specific
  public var generation: Int = 0

  public init() {}

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
      return "[key: \(key), value: \(String(describing: svalue ?? _e)), epoch: \(epoch), generation: \(generation))]"
    }
}
