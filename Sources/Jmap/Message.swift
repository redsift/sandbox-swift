import Foundation
import ObjectMapper

public struct Message: Mappable {
  public var id: String?
  public var threadId: String?
  public var mailboxIds: [String]?
  public var inReplyToMessageId: String?
  public var isUnread: Bool?
  public var isFlagged: Bool?
  public var isAnswered: Bool?
  public var isDraft: Bool?
  public var hasAttachment: Bool?
  public var headers: [String:String]?
  public var from: Emailer?
  public var to: [Emailer]?
  public var cc: [Emailer]?
  public var bcc: [Emailer]?
  public var replyTo: Emailer?
  public var subject: String?
  public var data: String?
  public var size: Int?
  public var preview: String?
  public var textBody: String?
  public var htmlBody: String?
  public var strippedHtmlBody: String?
  public var attachments: [Attachment]?
  public var attachedMessages: [String: Message]?
  public var user: String?


  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    id <- map["id"]
    threadId <- map["threadId"]
    mailboxIds <- map["mailboxIds"]
    inReplyToMessageId <- map["inReplyToMessageId"]
    isUnread <- map["isUnread"]
    isFlagged <- map["isFlagged"]
    isAnswered <- map["isAnswered"]
    isDraft <- map["isDraft"]
    hasAttachment <- map["hasAttachment"]
    headers <- map["headers"]
    from <- map["from"]
    to <- map["to"]
    cc <- map["cc"]
    bcc <- map["bcc"]
    replyTo <- map["replyTo"]
    subject <- map["subject"]
    data <- map["data"]
    size <- map["size"]
    preview <- map["preview"]
    textBody <- map["textBody"]
    htmlBody <- map["htmlBody"]
    strippedHtmlBody <- map["strippedHtmlBody"]
    attachments <- map["attachments"]
    attachedMessages <- map["attachedMessages"]
    user <- map["user"]
  }
}
