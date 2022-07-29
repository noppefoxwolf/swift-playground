import Stencil

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
        let environment = Environment(loader: FileSystemLoader(bundle: [BundleToken.bundle]))
        let rendered = try! environment.renderTemplate(name: "Package.swift", context: [
            "package" : options
        ])
        return rendered
    }
}
