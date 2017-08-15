import Foundation
import ObjectMapper

public struct SiftJSON: Mappable {
  public var dag: Dag?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    dag <- map["dag"]
  }
}

public struct Dag: Mappable {
  public var nodes: [Node]?
  
  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    nodes <- map["nodes"]
  }
}

public struct Node: Mappable {
  public var description: String?
  public var implementation: String?

  public init?(map: Map){ }
  public mutating func mapping(map: Map) {
    description <- map["#"]
    implementation <- map["implementation.swift"]
  }
}


public struct Init{
  public var SIFT_ROOT: String
  public var SIFT_JSON: String
  public var IPC_ROOT: String
  public var DRY = false
  public var sift: SiftJSON
  public var nodes: [Int] = []

  public init?(args: [String]){
    guard args.count > 1 else{
      print("No nodes to execute")
      return nil
    }
    guard let srt = ProcessInfo.processInfo.environment["SIFT_ROOT"], srt != "" else{
      print("Environment SIFT_ROOT not set")
      return nil
    }
    guard srt.hasPrefix("/") else {
      print("Environment SIFT_ROOT \(srt) must be absolute")
      return nil
    }
    
    guard let sjt = ProcessInfo.processInfo.environment["SIFT_JSON"], sjt != "" else{
      print("Environment SIFT_JSON not set")
      return nil
    }

    guard let irt = ProcessInfo.processInfo.environment["IPC_ROOT"], irt != "" else{
      print("Environment IPC_ROOT not set")
      return nil
    }
    
    if ProcessInfo.processInfo.environment["DRY"] == "true" {
      self.DRY = true
      print("Unit Test Mode")
    }

    guard let jsonString = try? String(contentsOfFile: sjt, encoding: .utf8) else{
      print("Could not read content of sift.json")
      return nil
    }
    guard let jsonData = SiftJSON(JSONString: jsonString),
      let jd = jsonData.dag,
      let jdn = jd.nodes, jdn.count > 0 else{
      print("Sift does not contain any nodes")
      return nil
    }
    
    for s in args[1..<args.count] {
      guard let ti = Int(s) else {
        print("Node index could not be parsed as Int")
        return nil
      }
      self.nodes.append(ti)
    }

    self.SIFT_ROOT = srt
    self.SIFT_JSON = sjt
    self.IPC_ROOT = irt
    self.sift = jsonData
  }
}


