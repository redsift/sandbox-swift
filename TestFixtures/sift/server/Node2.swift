import Redsift

public class Node2: Redsift.RedsiftNode{
  public static func compute(req: ComputeRequest) -> Any?{
    print("2: Returning with a ComputeResponse")
    return ComputeResponse(name: "name", key: "key1", value: ["stringvalue"])
  }
}