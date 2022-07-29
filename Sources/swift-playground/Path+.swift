import Foundation
import PathKit

extension Path {
  static let bundledTemplates = Path(Bundle.module.path(forResource: "templates", ofType: nil) ?? "")
}
