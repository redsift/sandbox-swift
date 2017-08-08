import PackageDescription

// let jmap = Package(
//   name: "Jmap",
//   targets: [],
//   dependencies: [],
//   exclude: []
// )

let redsift = Package(
  name: "Redsift",
  targets: [],
  dependencies: [
    .Package(url: "https://github.com/Hearst-DD/ObjectMapper.git", majorVersion: 2, minor: 2),
  ],
  exclude: []
)