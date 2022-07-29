import Foundation
import Stencil
import PathKit

struct AppRenderer {
	func render() -> String {
        let path = Path(Bundle.module.path(forResource: "templates", ofType: nil)!) + "App.swift.stencil"
        let template: String = try! path.read()
        let environment = Environment()
        let rendered = try! environment.renderTemplate(string: template, context: [:])
        return rendered
	}
}
