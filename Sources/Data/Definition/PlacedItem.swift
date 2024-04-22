//

import Foundation

struct PlacedItem {
	let id: Int
	let containerId: Int?
	let containerOrder: Int
	let count: Int
}

// MARK: - Codable
extension PlacedItem: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		containerId = try container.decodeIfPresent(Int.self, forKey: .containerId)
		containerOrder = try container.decodeIfPresent(Int.self, forKey: .containerId) ?? 0
		let count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 1
		self.count = count > 0 ? count : Item.infinite
	}
}
