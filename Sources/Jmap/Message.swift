import Foundation
import ObjectMapper

public struct Message: Mappable {
  var id: String?
  var threadId: String?
  var mailboxIds: [String]?
  var inReplyToMessageId: String?
  var isUnread: Bool?
  var isFlagged: Bool?
  var isAnswered: Bool?
  var isDraft: Bool?
  var hasAttachment: Bool?
  var headers: [String:String]?
  var from: Emailer?
  var to: [Emailer]?
  var cc: [Emailer]?
  var bcc: [Emailer]?
  var replyTo: Emailer?
  var subject: String?
  var data: String?
  var size: Int?
  var preview: String?
  var textBody: String?
  var htmlBody: String?
  var strippedHtmlBody: String?
  var attachments: [Attachment]?
  var attachedMessages: [String: Message]?
  var user: String?


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
