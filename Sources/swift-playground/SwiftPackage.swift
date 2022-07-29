public struct Package: Codable {
    public let name: String
    public let products: [Product]
}

public struct Product: Codable {
    public let name: String
}
