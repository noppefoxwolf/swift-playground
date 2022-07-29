import Foundation
import Stencil
import PathKit

public struct AppRenderer {
    public init() {}
    public func render() -> String {
        let path = Path.bundledTemplates + "App.swift.stencil"
        let template: String = try! path.read()
        let environment = Environment()
        let rendered = try! environment.renderTemplate(string: template, context: [:])
        return rendered
	}
}
