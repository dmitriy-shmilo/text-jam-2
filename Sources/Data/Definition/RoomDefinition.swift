//

import Foundation

struct RoomRef: Codable, Hashable {
	let id: Int
	let areaId: Int
}

extension RoomRef {
	static let invalid = RoomRef(id: -1, areaId: -1)
}

struct RoomDefinition {
	let id: Int
	let name: String
	let description: String
	let exits: RoomExits
	let placedItems: [PlacedItem]
}

// MARK: - Codable
extension RoomDefinition: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.description = try container.decode(String.self, forKey: .description)
		self.exits = try container.decode(RoomExits.self, forKey: .exits)
		self.placedItems = try container.decodeIfPresent([PlacedItem].self, forKey: .placedItems) ?? []
	}
}

