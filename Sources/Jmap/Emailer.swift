import Foundation
import ObjectMapper

public struct Emailer: Mappable {
  public var name: String = ""
  public var email: String = ""

  public init(name: String, email: String){
    self.name = name
    self.email = email
  }
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
