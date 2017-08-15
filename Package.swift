import PackageDescription

// let jmap = Package(
//   name: "Jmap",
//   targets: [],
//   dependencies: [],
//   exclude: []
// )

let redsift = Package(
  name: "Redsift",
  targets: [
    Target(name: "Redsift"),
    Target(name: "Sift",dependencies: ["Redsift"]),
    Target(name: "Install",dependencies: ["Redsift"]),
    Target(name: "Run",dependencies: ["Redsift", "Sift"])
  ],
  dependencies: [
    .Package(url: "https://github.com/Hearst-DD/ObjectMapper.git", majorVersion: 2, minor: 2),
    .Package(url: "https://github.com/redsift/NanoMessage.git", majorVersion: 0),
    .Package(url: "https://github.com/oarrabi/Guaka.git", majorVersion: 0),
    .Package(url: "https://github.com/oarrabi/FileUtils.git", majorVersion: 0),
  ],
  exclude: []
)