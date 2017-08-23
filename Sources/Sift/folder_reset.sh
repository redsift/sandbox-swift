#!/bin/bash
rm -rf ./*.swift ./Node*

cat > Sift.swift << EOF
import Redsift

public struct Sift {
  public static let computes : [Int : (ComputeRequest) -> Any?] = [:]
}
EOF
