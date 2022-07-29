install:
	swift build --configuration release
	-rm ~/.local/bin/swift-playground
	mkdir -p ~/.local/bin/
	cp .build/release/swift-playground ~/.local/bin/swift-playground

debug:
	swift build --configuration release
	-rm ~/.local/bin/swift-playground
	mkdir -p ~/.local/bin/
	cp .build/release/swift-playground ~/.local/bin/swift-playground
	swift playground init ./Example --name Example
