//

import Foundation

struct RoomDefinition {
	let id: Int
	let name: String
	let description: String
	let exits: RoomExits
	let placedItems: [PlacedItem]
	let placedActors: [PlacedActor]
}

// MARK: - Codable
extension RoomDefinition: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		description = try container.decode(String.self, forKey: .description)
		exits = try container.decode(RoomExits.self, forKey: .exits)
		placedItems = try container.decodeIfPresent([PlacedItem].self, forKey: .placedItems) ?? []
		placedActors = try container.decodeIfPresent([PlacedActor].self, forKey: .placedActors) ?? []
	}
}

