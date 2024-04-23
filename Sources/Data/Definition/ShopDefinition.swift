//

import Foundation

struct ShopDefinition {
	let id: Int
	let room: RoomRef
	let shopkeeps: [Int]
	let buyTags: [String]
	let items: [PlacedItem]
}

// MARK: - Codable
extension ShopDefinition: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		room = try container.decode(RoomRef.self, forKey: .room)
		shopkeeps = try container.decodeIfPresent([Int].self, forKey: .shopkeeps) ?? []
		buyTags = try container.decodeIfPresent([String].self, forKey: .buyTags) ?? []
		items = try container.decodeIfPresent([PlacedItem].self, forKey: .items) ?? []
	}
}
