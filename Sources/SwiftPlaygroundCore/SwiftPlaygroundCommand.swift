import ArgumentParser

public struct SwiftPlaygroundCommand: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "swift-playground",
        subcommands: [
            Init.self
        ]
    )

    public init() {}
}
