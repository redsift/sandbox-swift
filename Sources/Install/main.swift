import Foundation
import Redsift

let SWIFT_SIFT_LOCATION = "/tmp/sandbox/Sources/Sift"
let fm = FileManager()

print("Installation starting...")
guard let info = Init(args: CommandLine.arguments) else{
  exit(0)
}

// TODO: break should become exits
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
  // Opt in for this implementation when copyItem lower is implemented
  // guard fm.fileExists(atPath: absoluteNodeImpl) else {
  guard let contentsOfNode = try? String(contentsOfFile: absoluteNodeImpl, encoding: .utf8) else{
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
    // NOT IMPLEMENTED YET:
    // try fm.copyItem(atPath: absoluteNodeImpl , toPath: newNodeImpl)
    try contentsOfNode.write(toFile: newNodeImpl, atomically:false, encoding: .utf8)
  }catch let error{
    // print("Copying \(newNodeImpl) to: \(absoluteNodeImpl) file failed: \(error)")
    print("Writting to \(newNodeImpl) file failed: \(error)")
    break
  }

}

writeSiftFileUtil("\(SWIFT_SIFT_LOCATION)/Sift.swift", availableComputeNodes)

shellUtil("/usr/bin/swift", ["build"])
