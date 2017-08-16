import Foundation

func writeSiftFileUtil(_ path: String, _ nodes: [String]){
  // TODO: change Optional Type
  let siftFileTemplate = "import Redsift\n" +
    "public struct Sift {\n" +
    "public static let computes : [(ComputeRequest?) -> Any?] = [\(nodes.joined(separator: ","))]" + 
      "\n}"

  do {
    try siftFileTemplate.write(toFile: path, atomically:false, encoding: .utf8)
  }catch let error{
    print("Writting Sift.swift file failed: \(error)")
  }
}

func shellUtil(_ launchPath: String,_ arguments: [String]) {
  let task = Process()
  task.launchPath = launchPath
  task.arguments = arguments

  task.standardOutput = FileHandle.standardOutput
  task.standardError = FileHandle.standardError
  task.launch()

  task.waitUntilExit()
}