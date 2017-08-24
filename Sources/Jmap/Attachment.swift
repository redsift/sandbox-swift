import Foundation
import ObjectMapper

public struct Attachment: Mappable {
  public var blobId: String = ""
  public var type: String = ""
  public var name: String = ""
  public var size: Int = 0
  public var isInline: Bool = false

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    blobId <- map["blobId"]
    type <- map["type"]
    name <- map["name"]
    size <- map["size"]
    isInline <- map["isInline"]
  }
}
