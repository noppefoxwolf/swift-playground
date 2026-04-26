import Foundation

struct PackageOptions {
    let swiftVersion: String
    let name: String
    let platform: String
    let bundleIdentifier: String
    let teamIdentifier: String

    struct Dependency {
        let productName: String
        let packageName: String
    }
    let dependency: Dependency?
}

struct PackageRenderer {
    let options: PackageOptions

    func render() throws -> String {
        let template = try URL.bundledTemplate(named: "Package.swift.stencil")
        return TemplateRenderer(
            values: [
                "package.swiftVersion": options.swiftVersion,
                "package.name": options.name,
                "package.platform": options.platform,
                "package.bundleIdentifier": options.bundleIdentifier,
                "package.teamIdentifier": options.teamIdentifier,
                "package.dependency.productName": options.dependency?.productName ?? "",
                "package.dependency.packageName": options.dependency?.packageName ?? "",
            ],
            conditions: [
                "package.dependency": options.dependency != nil
            ]
        ).render(template)
    }
}

private struct TemplateRenderer {
    let values: [String: String]
    let conditions: [String: Bool]

    func render(_ template: String) -> String {
        renderVariables(
            in: renderConditionals(in: template)
        )
    }

    private func renderVariables(in template: String) -> String {
        values.reduce(template) { rendered, value in
            rendered.replacingOccurrences(
                of: "{{ \(value.key) }}",
                with: value.value
            )
        }
    }

    private func renderConditionals(in template: String) -> String {
        conditions.reduce(template) { rendered, condition in
            let openingTag = "{% if \(condition.key) %}"
            let closingTag = "{% endif %}"

            var output = rendered
            while let openingRange = output.range(of: openingTag),
                  let closingRange = output.range(
                    of: closingTag,
                    range: openingRange.upperBound..<output.endIndex
                  ) {
                let contentRange = openingRange.upperBound..<closingRange.lowerBound
                let replacement = condition.value ? String(output[contentRange]) : ""
                output.replaceSubrange(
                    openingRange.lowerBound..<closingRange.upperBound,
                    with: replacement
                )
            }
            return output
        }
    }
}
