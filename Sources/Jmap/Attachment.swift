import Foundation
import ObjectMapper

public struct Attachment: Mappable {
  public var blobId: String?
  public var type: String?
  public var name: String?
  public var size: Int?
  public var isInline: Bool?
  public var width: Int?
  public var height: Int?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    blobId <- map["blobId"]
    type <- map["type"]
    name <- map["name"]
    size <- map["size"]
    isInline <- map["isInline"]
    width <- map["width"]
    height <- map["height"]
  }
}
