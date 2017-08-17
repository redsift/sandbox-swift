import Foundation
import Dispatch
import NanoMessage
import Redsift
import Sift


print("Running...")
guard let info = Init(args: CommandLine.arguments) else {
  exit(0)
}


let dg = DispatchGroup()
for i in info.nodes {
  guard let sjdag = info.sift.dag, let sjnodes = sjdag.nodes else {
    print("something went wrong")
    exit(1)
  }

  let node = sjnodes[i]
  guard let nodeImpl = node.implementation else {
    print("Requested to install a non-Swift node at index \(i)")
    exit(1)
  }

  print("Running node: \(node.description ?? String(describing: i)) :\(nodeImpl)")

  if(info.DRY){
    continue
  }
  let addr = "ipc://\(info.IPC_ROOT)/\(i).sock"
  let dwi = DispatchWorkItem{
    print("dispatching node: \(i) to thread...")
    _ = NodeThread(name: i, addr: addr)
  }
  DispatchQueue.global(qos: .userInteractive)
    .async(group: dg, execute: dwi)
}

dg.wait()
//print message when all blocks in the group finish
dg.notify(queue: DispatchQueue.global()) {
    print("dispatch group over")
}
