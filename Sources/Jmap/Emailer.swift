import Foundation
import ObjectMapper

public struct Emailer: Mappable {
  var name: String?
  var email: String?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    name <- map["name"]
    email <- map["email"]
  }
}

extension Emailer: CustomStringConvertible {
  public var description: String{
    return "[< \(String(describing: name)) > \(String(describing: email))]"
  }
}
