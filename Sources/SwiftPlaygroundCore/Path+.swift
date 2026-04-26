import Foundation
import PathKit

extension Path {
    static var bundledTemplates: Path {
        Path(Bundle.module.path(forResource: "templates", ofType: nil) ?? "")
    }
}
