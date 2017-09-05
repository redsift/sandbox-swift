import Foundation
import ObjectMapper

public struct Request: Mappable {
  public var remoteAddr: String = ""
  public var method: String = ""
  public var requestUri: String = ""
  public var header: Header?
  public var body: Data?

  public init(_ remoteAddr: String, _ method: String, _ requestUri: String, _ header: Header, _ body: Data){
    self.remoteAddr = remoteAddr
    self.method = method
    self.requestUri = requestUri
    self.header = header
    self.body = body
  }

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    remoteAddr <- map["remote_addr"]
    method <- map["method"]
    requestUri <- map["request_uri"]
    header <- map["header"]
    body <- (map["body"], DataTransform())
  }
}
