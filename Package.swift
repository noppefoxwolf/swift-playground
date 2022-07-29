// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-playground",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "swift-playground", targets: ["swift-playground"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.3"),
        .package(url: "https://github.com/stencilproject/Stencil", from: "0.14.2"),
        .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.1"),
    ],
    targets: [
        .executableTarget(
            name: "swift-playground",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                ),
                "Stencil",
                "PathKit"
            ],
            resources: [
                .copy("templates")
            ]
        )
    ]
)
