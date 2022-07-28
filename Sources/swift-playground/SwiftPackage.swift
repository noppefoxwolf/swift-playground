struct Package: Codable {
    let name: String
    let products: [Product]
    let dependencies: [Dependency]
    let targets: [Target]
}

struct Product: Codable {
    let name: String
}

struct Dependency: Codable {
    let sourceControl: [SourceControl]
}

struct SourceControl: Codable {
    let identity: String
    let location: Location
    let requirement: Requirement
}

struct Location: Codable {
    let remote: [String]
}

struct Requirement: Codable {
    let range: [Range]
}

struct Range: Codable {
    let lowerBound: String
    let upperBound: String
}

struct Target: Codable {
    let dependencies: [TargetDependency]
    let name: String
    let type: String
}

struct TargetDependency: Codable {
    let product: [String?]
}
