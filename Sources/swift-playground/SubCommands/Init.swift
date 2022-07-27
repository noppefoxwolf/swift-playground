import ArgumentParser
import Foundation

extension SwiftPlaygroundCommand {
    struct Init: ParsableCommand {
        @Option
        var name: String = "Playground"
        
        @Option
        var bundleIdentifier: String = UUID().uuidString
        
        @Option
        var teamIdentifier: String = ""
        
        func run() throws {
            let rootPath = URL(
                fileURLWithPath: FileManager.default.currentDirectoryPath
            )
            let workspacePath = rootPath.appendingPathComponent("\(name).swiftpm")
            let packagePath = workspacePath.appendingPathComponent("Package.swift")
            let appPath = workspacePath.appendingPathComponent("App.swift")
            
            if !FileManager.default.fileExists(atPath: workspacePath.path) {
                try FileManager.default.createDirectory(
                    at: workspacePath,
                    withIntermediateDirectories: false
                )
            }
            
            try Package(
                name: name,
                bundleIdentifier: bundleIdentifier,
                teamIdentifier: teamIdentifier
            )
            .make()
            .write(to: packagePath, atomically: true, encoding: .utf8)
            
            try App()
                .make()
                .write(to: appPath, atomically: true, encoding: .utf8)
        }
    }
}

