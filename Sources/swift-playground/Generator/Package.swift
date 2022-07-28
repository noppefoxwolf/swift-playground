import Stencil

struct PackageOptions {
    let name: String
    let bundleIdentifier: String
    let teamIdentifier: String
    let hasDependencyPlaceholder: Bool
}

struct PackageRenderer {
    let options: PackageOptions
    
    func render() -> String {
        let environment = Environment(loader: FileSystemLoader(bundle: [.module]))
        let rendered = try! environment.renderTemplate(name: "Package.swift", context: [
            "package" : options
        ])
        return rendered
    }
}
