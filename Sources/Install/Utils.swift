import Foundation

func writeSiftFileUtil(_ path: String, _ nodes: [Int : String]){
  let snodes = String(describing: nodes).replacingOccurrences(of: "\"", with: "")
  let siftFileTemplate = "import Redsift\n" +
    "public struct Sift {\n" +
    "public static let computes : [Int : (ComputeRequest) -> Any?] = \(snodes)" + 
      "\n}"

  do {
    try siftFileTemplate.write(toFile: path, atomically:false, encoding: .utf8)
  }catch let error{
    print("Writting Sift.swift file failed: \(error)")
  }
}

func shellUtil(_ launchPath: String,_ arguments: [String]) -> Int32 {
  let task = Process()
  task.launchPath = launchPath
  task.arguments = arguments

  task.standardOutput = FileHandle.standardOutput
  task.standardError = FileHandle.standardError
  task.launch()

  task.waitUntilExit()
  return task.terminationStatus
}