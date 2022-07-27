struct Package {
    let name: String
    let bundleIdentifier: String
    let teamIdentifier: String
    
    func make() -> String {
        """
        // swift-tools-version: 5.6
        
        import PackageDescription
        import AppleProductTypes

        let package = Package(
            name: "\(name)",
            platforms: [
                .iOS("15.2")
            ],
            products: [
                .iOSApplication(
                    name: "\(name)",
                    targets: ["AppModule"],
                    bundleIdentifier: "\(bundleIdentifier)",
                    teamIdentifier: "\(teamIdentifier)",
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
            targets: [
                .executableTarget(
                    name: "AppModule",
                    path: "."
                )
            ]
        )
        """
    }
}
