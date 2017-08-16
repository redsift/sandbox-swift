import Foundation
import Dispatch
import NanoMessage
import Redsift
import Sift

// DispatchQueue.global(qos: .userInitiated).async {

// }




let dispatchWorkItem = DispatchWorkItem{
    print("work item start")
    sleep(1)
    print("work item end")
}

let dg = DispatchGroup()
//submit work items to the group
DispatchQueue.global().async(group: dg, execute: dispatchWorkItem)
let dispatchQueue = DispatchQueue(label: "custom dq")
dispatchQueue.async(group: dg) {
    print("block start")
    sleep(2)
    print("block end")
}
//print message when all blocks in the group finish
dg.notify(queue: DispatchQueue.global()) {
    print("dispatch group over")
}

dg.wait()
