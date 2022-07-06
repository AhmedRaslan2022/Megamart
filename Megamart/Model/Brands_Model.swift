

import Foundation

// MARK: - Brands
struct Brands: Codable {
    let smartCollections: [SmartCollection]

    enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
    }
}

// MARK: - SmartCollection
struct SmartCollection: Codable {
    let id: Int
    let handle, title: String

    let image: Image

}
