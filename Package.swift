import PackageDescription

let redsift = Package(
  name: "Redsift",
  targets: [
    Target(name: "Jmap"),
    Target(name: "Redsift"),
    Target(name: "Sift",dependencies: ["Jmap", "Redsift"]),
    Target(name: "Install",dependencies: ["Redsift"]),
    Target(name: "Run",dependencies: ["Redsift", "Sift"])
  ],
  dependencies: [
    .Package(url: "https://github.com/Hearst-DD/ObjectMapper.git", majorVersion: 2, minor: 2),
    .Package(url: "https://github.com/redsift/NanoMessage.git", majorVersion: 0, minor: 3),
  ],
  exclude: []
)