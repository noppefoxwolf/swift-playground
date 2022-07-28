// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Example",
    products: [
        .library(name: "Module1", targets: ["Module"]),
        .library(name: "Module2", targets: ["Module"]),
        .library(name: "Module3", targets: ["Module"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Module"
        )
    ]
)
