import Stencil

struct AppRenderer {
	func render() -> String {
        let environment = Environment(loader: FileSystemLoader(bundle: [.module]))
        let rendered = try! environment.renderTemplate(name: "App.swift", context: [:])
        return rendered
	}
}
