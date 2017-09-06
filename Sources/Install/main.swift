import Foundation
import Redsift

let fm = FileManager()

print("Installation starting...")
guard let info = Init(args: CommandLine.arguments) else{
  exit(0)
}

var SWIFT_SOURCES_LOCATION = "/usr/lib/redsift/sandbox"
// let sloc = ProcessInfo.processInfo.environment["SWIFT_SOURCES_LOCATION"]
// if sloc != nil && sloc! != "" {
//   SWIFT_SOURCES_LOCATION = sloc!
//   print("Environment SWIFT_SOURCES_LOCATION is set to: \(String(describing: sloc))")
// }

var availableComputeNodes: [Int: String] = [:]
for i in info.nodes {
  guard let sjdag = info.sift.dag, let sjnodes = sjdag.nodes else {
    print("something went wrong during initialization")
    exit(1)
  }
 
  let node = sjnodes[i]
  guard let nodeImpl = node.implementation else {
    print("Requested to install a non-Swift node at index \(i)")
    exit(1)
  }

  print("Installing node: \(node.description!) : \(nodeImpl)");

  // checking if the file exists
  let absoluteNodeImpl = "\(info.SIFT_ROOT)/\(nodeImpl)"
  // Opt in for this implementation when copyItem lower is implemented
  // guard fm.fileExists(atPath: absoluteNodeImpl) else {
  guard let contentsOfNode = try? String(contentsOfFile: absoluteNodeImpl, encoding: .utf8) else{
    print("Implementation at index \(i) (\(nodeImpl)) does not exist!")
    exit(1)
  }
  
  let implPathComp = nodeImpl.components(separatedBy: "/")
  let nodeImplName = implPathComp[implPathComp.count-1]
  availableComputeNodes[i] = ("\(nodeImplName.replacingOccurrences(of: "swift", with:"compute"))")

  let newNodeImpl = nodeImpl.replacingOccurrences(of: "server", with: "\(SWIFT_SOURCES_LOCATION)/Sources/Sift")
  let newImplPath = newNodeImpl.replacingOccurrences(of: "/\(nodeImplName)", with: "")
  
  do {
    // create intermediate folders
    try fm.createDirectory(atPath: newImplPath, withIntermediateDirectories: true, attributes:nil)
  }catch let error {
    print("Failed to create intermediate directories for: \(newImplPath)")
    print(error)
    exit(1)
  }

  do {
    // copy file
    // NOT IMPLEMENTED YET:
    // try fm.copyItem(atPath: absoluteNodeImpl , toPath: newNodeImpl)
    try contentsOfNode.write(toFile: newNodeImpl, atomically:false, encoding: .utf8)
  }catch let error{
    // print("Copying \(newNodeImpl) to: \(absoluteNodeImpl) file failed: \(error)")
    print("Writting to \(newNodeImpl) file failed: \(error)")
    exit(1)
  }

}

writeSiftFileUtil("\(SWIFT_SOURCES_LOCATION)/Sources/Sift/Sift.swift", availableComputeNodes)

var code = shellUtil("/usr/bin/swift", ["build", "-c", "release", "--build-path", "\(info.SIFT_ROOT)/server/.build"])
if code > 0 {
  print("Build failed check for errors above.")
  exit(code)
}
