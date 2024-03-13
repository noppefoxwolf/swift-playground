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
        
        @Option
        var platform: String = #".iOS(.v17)"#
        
        @Option
        var swiftVersion: String = "5.10"
        
        func run() throws {
            let currentDirectoryURL = URL(
                fileURLWithPath: path
            )
            let playgroundURL = currentDirectoryURL.appendingPathComponent("\(name).swiftpm")
            let playgroundPackageURL = playgroundURL.appendingPathComponent("Package.swift")
            let playgroundAppURL = playgroundURL.appendingPathComponent("App.swift")
            
            let currentPackageURL = currentDirectoryURL.appendingPathComponent("Package.swift")
            let dependency = try chooseDependency(
                packageSwiftURL: currentPackageURL
            )
            
            if !FileManager.default.fileExists(atPath: playgroundURL.path) {
                try FileManager.default.createDirectory(
                    at: playgroundURL,
                    withIntermediateDirectories: false
                )
            }
            
            let packageOptions = PackageOptions(
                swiftVersion: swiftVersion,
                name: name,
                platform: platform,
                bundleIdentifier: bundleIdentifier,
                teamIdentifier: teamIdentifier,
                dependency: dependency
            )
            try PackageRenderer(options: packageOptions)
                .render()
                .write(to: playgroundPackageURL, atomically: true, encoding: .utf8)
            
            try AppRenderer()
                .render()
                .write(to: playgroundAppURL, atomically: true, encoding: .utf8)
            
            openPlayground(url: playgroundURL)
        }
        
        func chooseDependency(packageSwiftURL: URL) throws -> PackageOptions.Dependency? {
            guard FileManager.default.fileExists(atPath: packageSwiftURL.path) else {
                return nil
            }
            let package = try getSwiftPackage(url: packageSwiftURL)
            if package.products.count == 0 {
                return nil
            }
            if package.products.count == 1 {
                return PackageOptions.Dependency(
                    productName: package.products[0].name,
                    packageName: package.name
                )
            }
            
            print("Choose dependency product:")
            let products = package.products.map(\.name).enumerated()
            for (offset, product) in products {
                print("\(offset)) \(product)")
            }
            print("Enter the number of the product to select:")
            while let input = readLine(strippingNewline: true) {
                if let offset = Int(input) {
                    let packageName = package.name
                    let productName = package.products[offset].name
                    return PackageOptions.Dependency(
                        productName: productName,
                        packageName: packageName
                    )
                }
                break
            }
            return nil
        }
        
        func getSwiftPackage(url: URL) throws -> Package {
            let process = Process()
            let pipe = Pipe()
            process.currentDirectoryPath = url.deletingLastPathComponent().path
            process.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
            process.arguments = ["package", "--package-path", url.deletingLastPathComponent().path, "dump-package"]
            process.standardOutput = pipe
            process.launch()
            let jsonData = pipe.fileHandleForReading.readDataToEndOfFile()
            let package = try JSONDecoder().decode(Package.self, from: jsonData)
            return package
        }
        
        func openPlayground(url: URL) {
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/xed")
            process.arguments = [url.path]
            process.launch()
        }
    }
}

