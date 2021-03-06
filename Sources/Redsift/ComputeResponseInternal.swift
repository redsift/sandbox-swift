import Foundation
import ObjectMapper

struct ComputeResponseInternal: Mappable {
  var name: String?
  var key: String!
  var value: Data?
  var epoch: Int? //platform specific

  public init(name: String = "", key: String, value: Data? = nil, epoch: Int = 0){
    self.name = name
    self.key = key
    self.value = value
    self.epoch = epoch
  }

  public init(cr: ComputeResponse){
    self.name = cr.name
    self.key = cr.key
    self.epoch = cr.epoch

    guard let t = cr.value else{
      self.value = nil
      return
    }

    if t is Data {
      // no op
    }else if t is String{
      let s = t as! String
      self.value = Optional(Data(bytes: [UInt8](s.utf8)))
    }else{
      do{
        let enc = try JSONSerialization.data(withJSONObject: t)
        self.value = Optional(enc)
      }catch{
        print("encoding object as json failed \(error)")
        self.value = nil
      }
    }
  }

  init?(map: Map){ }
  public mutating func mapping(map: Map) {
    name <- map["name"]
    key <- map["key"]
    value <- (map["value"], DataTransform())
    epoch <- map["epoch"]
  }
}

extension ComputeResponseInternal: CustomStringConvertible {
    public var description: String {
      let _e: Any = "nil"
      return "[name: \(String(describing: name ?? _e)), key: \(String(describing: key ?? _e)), value: \(String(describing: value ?? _e)), epoch: \(String(describing: epoch ?? _e))]"
    }
}