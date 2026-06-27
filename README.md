# swift-playground

Create an Xcode Playgrounds app package (`.swiftpm`) next to an existing Swift
package.

`swift playground init` reads the current package's `Package.swift`, lets you
choose a product when there are multiple products, and generates a Playgrounds
app that depends on the selected local package product.

![](https://github.com/noppefoxwolf/swift-playground/blob/main/.github/sample.gif)

## Requirements

- macOS 12 or later
- Swift 6.3
- Xcode with `xed`

## Installation

Install the command with SwiftPM:

```sh
swift package experimental-install
```

Uninstall it with:

```sh
swift package experimental-uninstall swift-playground
```

## Usage

Run `init` from the root of a Swift package:

```sh
swift playground init
```

By default this creates `Example.swiftpm` in the current directory, writes
`Package.swift` and `App.swift` into it, and opens the generated playground with
`xed`.

When the source package exposes multiple products, choose the product to import
into the playground app:

```text
$ swift playground init
Choose dependency product:
0) EditModule
1) SettingsModule
Enter the number of the product to select:
```

If the source package has one product, it is selected automatically. If there is
no `Package.swift` or the package has no products, the playground is generated
without a local package dependency.

### Options

```sh
swift playground init [path] \
  --name Example \
  --bundle-identifier com.example.app \
  --team-identifier TEAMID \
  --platform '.iOS(.v26)' \
  --swift-version 6.3
```

- `path`: Directory where the `.swiftpm` package is created. Defaults to the
  current directory.
- `--name`: Playground package and app name. Defaults to `Example`.
- `--bundle-identifier`: Bundle identifier for the generated app. Defaults to a
  generated UUID.
- `--team-identifier`: Apple Developer Team ID. Defaults to an empty string.
- `--platform`: Package platform expression. Defaults to `.iOS(.v26)`.
- `--swift-version`: Swift tools version for the generated package. Defaults to
  `6.3`.

## Generated Package

The generated playground contains:

- `Package.swift`: an `.iOSApplication` package using `AppleProductTypes`
- `App.swift`: a minimal SwiftUI app entry point

When a dependency product is selected, the generated package adds
`.package(path: "../")` and links the selected product into the `AppModule`
target.

## Development

Run the test suite with:

```sh
swift test
```

## Author

[noppefoxwolf](https://twitter.com/noppefoxwolf)
