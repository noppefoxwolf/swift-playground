import SwiftPlaygroundCore

struct SwiftPlaygroundCLI {
    static func main() async {
        await SwiftPlaygroundCommand.main()
    }
}

await SwiftPlaygroundCLI.main()
