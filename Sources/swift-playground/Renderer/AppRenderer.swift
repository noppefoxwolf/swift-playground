import Stencil

struct AppRenderer {
	func render() -> String {
        let environment = Environment(loader: FileSystemLoader(bundle: [BundleToken.bundle]))
        let rendered = try! environment.renderTemplate(name: "App.swift", context: [:])
        return rendered
	}
}
