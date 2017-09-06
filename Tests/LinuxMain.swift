import XCTest
@testable import JmapTests
@testable import RpcTests
@testable import RedsiftTests

XCTMain([
    testCase(RunTests.allTests),
    // testCase(RedsiftInitTests.allTests),
    // testCase(ProtocolTests.allTests),
    // testCase(JmapTests.allTests),
    // testCase(RpcTests.allTests)
])
