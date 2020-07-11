// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ShellySwift",
    products: [
        .library(
            name: "ShellySwift",
            targets: ["ShellySwift"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ShellySwift",
            dependencies: []),
        .testTarget(
            name: "ShellySwiftTests",
            dependencies: ["ShellySwift"]),
    ]
)
