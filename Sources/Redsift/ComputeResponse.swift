import Foundation

public struct ComputeResponse {
  var name: String?
  var key: String!
  var value: Any?
  var epoch: Int? //platform specific

  public init(name: String? = nil, key: String, value: Any? = nil, epoch: Int = 0){
    self.name = name
    self.key = key
    self.value = value
    self.epoch = epoch
  }
}

extension ComputeResponse: CustomStringConvertible {
    public var description: String {
        return "[name: \(String(describing: name)), key: \(String(describing: key)), value: \(String(describing: value)), epoch: \(String(describing: epoch))]"
    }
}