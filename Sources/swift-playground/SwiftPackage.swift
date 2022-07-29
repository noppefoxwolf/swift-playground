struct Package: Codable {
    let name: String
    let products: [Product]
}

struct Product: Codable {
    let name: String
}
