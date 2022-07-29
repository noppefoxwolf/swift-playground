import Stencil
import Foundation
import PathKit

struct PackageOptions {
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
    
    func render() -> String {
        let path = Path(Bundle.module.path(forResource: "templates", ofType: nil)!) + "Package.swift.stencil"
        let template: String = try! path.read()
        let environment = Environment()
        let rendered = try! environment.renderTemplate(string: template, context: [
            "package" : options
        ])
        return rendered
    }
}
