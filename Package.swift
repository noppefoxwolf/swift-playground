// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-playground",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "swift-playground", targets: ["swift-playground"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.7.1"),
        .package(url: "https://github.com/stencilproject/Stencil", from: "0.15.1"),
        .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.1"),
    ],
    targets: [
        .executableTarget(
            name: "swift-playground",
            dependencies: [
                .target(name: "SwiftPlaygroundCore")
            ]
        ),
        .target(
            name: "SwiftPlaygroundCore",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                ),
                "Stencil",
                "PathKit",
            ],
            resources: [
                .copy("templates")
            ]
        ),
        .testTarget(
            name: "SwiftPlaygroundTests",
            dependencies: [
                .target(name: "SwiftPlaygroundCore")
            ]
        )
    ]
)
