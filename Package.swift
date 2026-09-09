// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "AgentTrunk",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "AgentTrunk",
            targets: ["AgentTrunk"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AgentTrunk",
            path: "sdk/swift/Sources"
        ),
        .testTarget(
            name: "AgentTrunkTests",
            dependencies: ["AgentTrunk"],
            path: "sdk/swift/Tests",
            exclude: ["AgentTrunk/manifest.json"]
        )
    ]
)
