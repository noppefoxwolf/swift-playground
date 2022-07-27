import Stencil

struct Package {
    let name: String
    let bundleIdentifier: String
    let teamIdentifier: String
    let hasDependencyPlaceholder: Bool
}

struct PackageRenderer {
    let package: Package
    
    func render() -> String {
        let environment = Environment(loader: FileSystemLoader(bundle: [.module]))
        let rendered = try! environment.renderTemplate(name: "Package.swift", context: [
            "package" : package
        ])
        return rendered
    }
}
