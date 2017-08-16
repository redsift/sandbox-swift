import Foundation
import ObjectMapper

public struct ComputeResponse: Mappable {
  var name: String?
  var key: String!
  var value: Any?
  var epoch: Int? //platform specific

  public init(name: String? = nil, key: String, value: Any? = nil, epoch: Int? = nil){
    self.name = name
    self.key = key
    self.value = value
    self.epoch = epoch
  }

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    name <- map["name"]
    key <- map["key"]
    value <- map["value"]
    epoch <- map["epoch"]
  }
}

extension ComputeResponse: CustomStringConvertible {
    public var description: String {
        return "[name: \(String(describing: name)), key: \(String(describing: key)), value: \(String(describing: value)), epoch: \(String(describing: epoch))]"
    }
}