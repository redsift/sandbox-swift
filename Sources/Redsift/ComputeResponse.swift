import Foundation
import ObjectMapper

struct ComputeResponse: Mappable {
  var name: String?
  var key: String?
  var value: Any?
  var epoch: Int? //platform specific

  init?(map: Map){ }
  mutating func mapping(map: Map) {
    name <- map["name"]
    key <- map["key"]
    value <- map["value"]
    epoch <- map["epoch"]
  }
}

extension ComputeResponse: CustomStringConvertible {
    var description: String {
        return "[name: \(String(describing: name)), key: \(String(describing: key)), value: \(String(describing: value)), epoch: \(String(describing: epoch))]"
    }
}