import Testing

@testable import SwiftPlaygroundCore

@Test
func swiftPlaygroundCommandHasExpectedName() {
    #expect(SwiftPlaygroundCommand.configuration.commandName == "swift-playground")
}

@Test
func appRendererRendersBundledTemplate() throws {
    let rendered = try AppRenderer().render()

    #expect(rendered.contains("import SwiftUI"))
    #expect(rendered.contains("Text(\"Hello, world!\")"))
}

@Test
func packageRendererRendersPackageWithoutDependency() throws {
    let rendered = try PackageRenderer(
        options: .fixture(dependency: nil)
    ).render()

    #expect(rendered.contains("// swift-tools-version: 6.3"))
    #expect(rendered.contains("name: \"Example\""))
    #expect(rendered.contains("bundleIdentifier: \"com.example.app\""))
    #expect(!rendered.contains(".package(path: \"../\")"))
    #expect(!rendered.contains(".product("))
    #expect(!rendered.contains("{{"))
    #expect(!rendered.contains("{%"))
}

@Test
func packageRendererRendersPackageWithDependency() throws {
    let rendered = try PackageRenderer(
        options: .fixture(
            dependency: .init(
                productName: "LibraryProduct",
                packageName: "library-package"
            )
        )
    ).render()

    #expect(rendered.contains(".package(path: \"../\")"))
    #expect(rendered.contains("name: \"LibraryProduct\""))
    #expect(rendered.contains("package: \"library-package\""))
    #expect(!rendered.contains("{{"))
    #expect(!rendered.contains("{%"))
}

private extension PackageOptions {
    static func fixture(dependency: Dependency?) -> PackageOptions {
        PackageOptions(
            swiftVersion: "6.3",
            name: "Example",
            platform: ".iOS(.v26)",
            bundleIdentifier: "com.example.app",
            teamIdentifier: "TEAMID",
            dependency: dependency
        )
    }
}
