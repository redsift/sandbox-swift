import Foundation
import ObjectMapper

struct SiftJSON: Mappable {
  var dag: Dag?

  init?(map: Map){ }
  mutating func mapping(map: Map) {
    dag <- map["dag"]
  }
}

struct Dag: Mappable {
  var nodes: [Node]?
  
  init?(map: Map){ }
  mutating func mapping(map: Map) {
    nodes <- map["nodes"]
  }
}

struct Node: Mappable {
  var description: String?
  var implementation: String?

  init?(map: Map){ }
  mutating func mapping(map: Map) {
    description <- map["#"]
    implementation <- map["implementation.swift"]
  }
}


struct Init{
  var SIFT_ROOT: String
  var SIFT_JSON: String
  var IPC_ROOT: String
  var DRY = false
  var sift: SiftJSON

  init?(){
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
    
    self.SIFT_ROOT = srt
    self.SIFT_JSON = sjt
    self.IPC_ROOT = irt
    self.sift = jsonData
  }
}


