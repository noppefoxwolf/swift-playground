import ArgumentParser

struct SwiftPlaygroundCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "swift-playground",
        subcommands: [
            Init.self,
        ]
    )
}

SwiftPlaygroundCommand.main()
