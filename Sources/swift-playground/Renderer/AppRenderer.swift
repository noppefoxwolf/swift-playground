import Foundation
import Stencil
import PathKit

struct AppRenderer {
    func render() throws -> String {
        let path = Path.bundledTemplates + "App.swift.stencil"
        let template: String = try path.read()
        let environment = Environment()
        let rendered = try environment.renderTemplate(string: template, context: [:])
        return rendered
	}
}
