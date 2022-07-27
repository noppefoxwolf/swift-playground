import ArgumentParser
import Foundation

extension SwiftPlaygroundCommand {
    struct Init: ParsableCommand {
        @Argument
        var path: String = FileManager.default.currentDirectoryPath
        
        @Option
        var name: String = "Playground"
        
        @Option
        var bundleIdentifier: String = UUID().uuidString
        
        @Option
        var teamIdentifier: String = ""
        
        func run() throws {
            let rootPath = URL(
                fileURLWithPath: path
            )
            let workspacePath = rootPath.appendingPathComponent("\(name).swiftpm")
            let packagePath = workspacePath.appendingPathComponent("Package.swift")
            let appPath = workspacePath.appendingPathComponent("App.swift")
            
            let currentPackagePath = rootPath.appendingPathComponent("Package.swift")
            let isPackagePath = FileManager.default.fileExists(atPath: currentPackagePath.path)
            
            if !FileManager.default.fileExists(atPath: workspacePath.path) {
                try FileManager.default.createDirectory(
                    at: workspacePath,
                    withIntermediateDirectories: false
                )
            }
            
            let package = Package(
                name: name,
                bundleIdentifier: bundleIdentifier,
                teamIdentifier: teamIdentifier,
                hasDependencyPlaceholder: isPackagePath
            )
            try PackageRenderer(package: package)
                .render()
                .write(to: packagePath, atomically: true, encoding: .utf8)
            
            try AppRenderer()
                .render()
                .write(to: appPath, atomically: true, encoding: .utf8)
        }
    }
}

