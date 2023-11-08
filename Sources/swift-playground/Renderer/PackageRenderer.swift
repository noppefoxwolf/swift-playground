import Stencil
import Foundation
import PathKit

struct PackageOptions {
    let swiftVersion: String
    let name: String
    let bundleIdentifier: String
    let teamIdentifier: String
    
    struct Dependency {
        let productName: String
        let packageName: String
    }
    let dependency: Dependency?
}

struct PackageRenderer {
    let options: PackageOptions
    
    func render() throws -> String {
        let path = Path.bundledTemplates + "Package.swift.stencil"
        let template: String = try path.read()
        let environment = Environment()
        let rendered = try environment.renderTemplate(
            string: template,
            context: [
                "package" : options
            ]
        )
        return rendered
    }
}
