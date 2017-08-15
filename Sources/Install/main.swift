import Foundation
import Redsift

let SWIFT_SIFT_LOCATION = "/tmp/sandbox/Sources/Sift"
let fm = FileManager()

// 
// Util Funcs
//

func writeSiftFile(nodes: [String]){
  // TODO: change Optional Type
  let siftFileTemplate = "import Redsift\n" +
    "public struct Sift {\n" +
    "public static let computes : [(ComputeRequest?) -> Any?] = [\(nodes.joined(separator: ","))]" + 
      "\n}"

  do {
    try siftFileTemplate.write(toFile: "\(SWIFT_SIFT_LOCATION)/Sift.swift", atomically:false, encoding: .utf8)
  }catch let error{
    print("Writting Sift.swift file failed: \(error)")
  }
}

// 
// End of Util Funcs 
// 

print("Installation starting...")
guard let info = Init(args: CommandLine.arguments) else{
  exit(0)
}

var availableComputeNodes: [String] = []
for i in info.nodes {
  guard let sjdag = info.sift.dag, let sjnodes = sjdag.nodes else {
    print("something went wrong")
    break
  }
 
  let node = sjnodes[i]
  guard let nodeImpl = node.implementation else {
    print("Requested to install a non-Swift node at index \(i)")
    break
  }

  print("Installing node: \(node.description!) : \(nodeImpl)");

  // checking if the file exists
  let absoluteNodeImpl = "\(info.SIFT_ROOT)/\(nodeImpl)"
  guard fm.fileExists(atPath: absoluteNodeImpl) else {
    print("Implementation at index \(i) (\(nodeImpl)) does not exist!")
    break
  }


  let implPathComp = nodeImpl.components(separatedBy: "/")
  let nodeImplName = implPathComp[implPathComp.count-1]
  availableComputeNodes.append("\(nodeImplName.replacingOccurrences(of: "swift", with:"compute"))")

  let newNodeImpl = nodeImpl.replacingOccurrences(of: "server", with: SWIFT_SIFT_LOCATION)
  let newImplPath = newNodeImpl.replacingOccurrences(of: "/\(nodeImplName)", with: "")
  
  do {
    // create intermediate folders
    try fm.createDirectory(atPath: newImplPath, withIntermediateDirectories: true, attributes:nil)
  }catch let error {
    print("Failed to create intermediate directories for: \(newImplPath)")
    print(error)
    break
  }

  do {
    // copy file
    try fm.copyItem(atPath: absoluteNodeImpl , toPath: newNodeImpl)
  }catch let error{
    print("Copying \(newNodeImpl) to: \(absoluteNodeImpl) file failed: \(error)")
  }

}

writeSiftFile(nodes: availableComputeNodes)
