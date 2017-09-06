import Foundation
import Dispatch
import NanoMessage
import Redsift
import Sift

setbuf(stdout, nil) // disable buffer for stdout to see prints
guard let info = Init(args: CommandLine.arguments) else {
  exit(0)
}


let dg = DispatchGroup()
for i in info.nodes {
  guard let sjdag = info.sift.dag, let sjnodes = sjdag.nodes else {
    print("something went wrong\n")
    exit(1)
  }

  let node = sjnodes[i]
  guard let nodeImpl = node.implementation else {
    print("Requested to install a non-Swift node at index \(i)\n")
    exit(1)
  }

  print("Running node: \(node.description ?? String(describing: i)): \(nodeImpl)\n")

  if(info.DRY){
    continue
  }
  let addr = "ipc://\(info.IPC_ROOT)/\(i).sock"
  let dwi = DispatchWorkItem{
    print("dispatching node: \(i) to thread...\n")
    _ = NodeThread(name: i, addr: addr)
  }
  DispatchQueue.global(qos: .userInteractive)
    .async(group: dg, execute: dwi)
}

if(info.DRY){
  exit(0)
}
dg.wait()
//print message when all blocks in the group finish
dg.notify(queue: DispatchQueue.global()) {
    print("dispatch group over\n")
}
