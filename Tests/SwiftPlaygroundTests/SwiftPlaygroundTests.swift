import Testing

@testable import SwiftPlaygroundCore

@Test
func swiftPlaygroundCommandHasExpectedName() {
    #expect(SwiftPlaygroundCommand.configuration.commandName == "swift-playground")
}
