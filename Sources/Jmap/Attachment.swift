import Foundation
import ObjectMapper

public struct Attachment: Mappable {
  var blobId: String?
  var type: String?
  var name: String?
  var size: Int?
  var isInline: Bool?
  var width: Int?
  var height: Int?

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
