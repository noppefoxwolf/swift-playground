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
    {% if package.dependency %}
    dependencies: [
        .package(path: "../")
    ],
    {% endif %}
    targets: [
        .executableTarget(
            name: "AppModule",
            {% if package.dependency %}
            dependencies: [
                .product(
                    name: "{{ package.dependency.productName }}",
                    package: "{{ package.dependency.packageName }}"
                )
            ],
            {% endif %}
            path: "."
        )
    ]
)
