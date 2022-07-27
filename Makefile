install:
	swift build --configuration release
	rm ~/.local/bin/swift-playground
	cp .build/release/swift-playground ~/.local/bin/swift-playground

debug:
	swift build --configuration release
	rm ~/.local/bin/swift-playground
	cp .build/release/swift-playground ~/.local/bin/swift-playground
	swift playground init --name Example