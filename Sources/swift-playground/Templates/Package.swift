// swift-tools-version: 5.6

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "{{ package.name }}",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "{{ package.name }}",
            targets: ["AppModule"],
            bundleIdentifier: "{{ package.bundleIdentifier }}",
            teamIdentifier: "{{ package.teamIdentifier }}",
            displayVersion: "1.0",
            bundleVersion: "1",
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    {% if package.hasDependencyPlaceholder %}
    dependencies: [
        .package(path: "../")
    ],
    {% endif %}
    targets: [
        .executableTarget(
            name: "AppModule",
            {% if package.hasDependencyPlaceholder %}
            dependencies: [
                // FIXME: Fill your dependency.
                .product(name: <#Name#>, package: <#Package#>)
            ],
            {% endif %}
            path: "."
        )
    ]
)
