import Foundation
import Stencil

struct AppRenderer {
	func render() -> String {
        let filePath = Bundle.module.path(forResource: "templates", ofType: nil)! + "/App.swift.stencil"
        let template = try! String(contentsOfFile: filePath)
        let environment = Environment()
        let rendered = try! environment.renderTemplate(string: template, context: [:])
        return rendered
	}
}
