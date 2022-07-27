
struct App {
	func make() -> String {
		"""
		import SwiftUI

		@main
		struct App: SwiftUI.App {
			var body: some Scene {
				WindowGroup {
					Text("Hello, world!")
				}
			}
		}
		"""
	}
}