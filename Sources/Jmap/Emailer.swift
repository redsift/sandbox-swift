import Foundation
import ObjectMapper

public struct Emailer: Mappable {
  public var name: String = ""
  public var email: String = ""

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    name <- map["name"]
    email <- map["email"]
  }
}

extension Emailer: CustomStringConvertible {
  public var description: String{
    return "[< \(name) > \(email))]"
  }
}
