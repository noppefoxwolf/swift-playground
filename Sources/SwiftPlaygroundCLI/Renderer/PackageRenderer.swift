import Stencil
import Foundation
import PathKit

public struct PackageOptions {
    public init(name: String, bundleIdentifier: String, teamIdentifier: String, dependency: PackageOptions.Dependency?) {
        self.name = name
        self.bundleIdentifier = bundleIdentifier
        self.teamIdentifier = teamIdentifier
        self.dependency = dependency
    }
    
    let name: String
    let bundleIdentifier: String
    let teamIdentifier: String
    
    public struct Dependency {
        public init(productName: String, packageName: String) {
            self.productName = productName
            self.packageName = packageName
        }
        
        let productName: String
        let packageName: String
    }
    let dependency: Dependency?
}

public struct PackageRenderer {
    public init(options: PackageOptions) {
        self.options = options
    }
    
    public let options: PackageOptions
    
    public func render() -> String {
        let path = Path.bundledTemplates + "Package.swift.stencil"
        let template: String = try! path.read()
        let environment = Environment()
        let rendered = try! environment.renderTemplate(string: template, context: [
            "package" : options
        ])
        return rendered
    }
}
