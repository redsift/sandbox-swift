#!/bin/bash
rm -rf ./*.swift ./Node1*

cat > Sift.swift << EOF
import Redsift

public struct Sift {
  public static let computes : [(ComputeRequest) -> Any?] = []
}
EOF
