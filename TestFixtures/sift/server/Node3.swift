import Redsift

public class Node3: Redsift.RedsiftNode{
  public static func compute(req: ComputeRequest) -> Any?{
    print("3: Returning with an unexpected type")
    return ["stringvalue"]
  }
}