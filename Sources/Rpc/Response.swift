import Foundation
import ObjectMapper

public struct Response: Mappable {
  public var statusCode: Int = 0
  public var header: Header?
  public var body: Data?

  public init(_ statusCode: Int, _ header: Header?, _ body: Data?){
    self.statusCode = statusCode
    self.header = header
    self.body = body
  }
  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    statusCode <- map["status_code"]
    header <- map["header"]
    body <- (map["body"], DataTransform())
  }
}
