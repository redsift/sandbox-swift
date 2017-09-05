#!/bin/bash

DEV_LOC=/Users/chrisvon/Documents/Developer/redsift
docker run \
-u 7438:7438
-v ${DEV_LOC}/sandbox-swift/TestFixtures/sift:/run/sandbox/sift \
-ti swifttest

# -v ${DEV_LOC}/sandbox-swift:/tmp/sandbox \