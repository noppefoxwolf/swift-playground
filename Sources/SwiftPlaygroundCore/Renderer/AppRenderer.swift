import Foundation

struct AppRenderer {
    func render() throws -> String {
        try URL.bundledTemplate(named: "App.swift.stencil")
    }
}
