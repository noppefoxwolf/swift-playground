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
            let currentDirectoryURL = URL(
                fileURLWithPath: path
            )
            let workspaceURL = currentDirectoryURL.appendingPathComponent("\(name).swiftpm")
            let packageURL = workspaceURL.appendingPathComponent("Package.swift")
            let appURL = workspaceURL.appendingPathComponent("App.swift")
            
            let currentPackageURL = currentDirectoryURL.appendingPathComponent("Package.swift")
            let dependency = chooseDependency(packageSwiftURL: currentPackageURL)
            
            if !FileManager.default.fileExists(atPath: workspaceURL.path) {
                try FileManager.default.createDirectory(
                    at: workspaceURL,
                    withIntermediateDirectories: false
                )
            }
            
            let packageOptions = PackageOptions(
                name: name,
                bundleIdentifier: bundleIdentifier,
                teamIdentifier: teamIdentifier,
                dependency: dependency
            )
            try PackageRenderer(options: packageOptions)
                .render()
                .write(to: packageURL, atomically: true, encoding: .utf8)
            
            try AppRenderer()
                .render()
                .write(to: appURL, atomically: true, encoding: .utf8)
        }
        
        func chooseDependency(packageSwiftURL: URL) -> PackageOptions.Dependency? {
            guard FileManager.default.fileExists(atPath: packageSwiftURL.path) else {
                return nil
            }
            guard let package = try? getSwiftPackage(url: packageSwiftURL) else {
                return nil
            }
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
    }
}

