//

import Foundation

struct ShopDefinition {
	let id: Int
	let room: RoomRef
	let requiredCharacters: [Int]
	let buyTags: [String]
	let items: [PlacedItem]
}

// MARK: - Codable
extension ShopDefinition: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		room = try container.decode(RoomRef.self, forKey: .room)
		requiredCharacters = try container.decodeIfPresent([Int].self, forKey: .requiredCharacters) ?? []
		buyTags = try container.decodeIfPresent([String].self, forKey: .buyTags) ?? []
		items = try container.decodeIfPresent([PlacedItem].self, forKey: .items) ?? []
	}
}
