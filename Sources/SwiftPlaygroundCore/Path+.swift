import Foundation

extension URL {
    static var bundledTemplates: URL {
        Bundle.module.url(forResource: "templates", withExtension: nil) ?? Bundle.module.bundleURL
    }

    static func bundledTemplate(named name: String) throws -> String {
        let url = bundledTemplates.appendingPathComponent(name)
        return try String(contentsOf: url, encoding: .utf8)
    }
}
