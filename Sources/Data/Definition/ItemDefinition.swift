//

import Foundation

struct ItemDefinitions: Codable {
	let items: [ItemDefinition]
}

// MARK: - Codable
struct ItemDefinition: Codable {
	let id: Int
	let name: String
	private(set) var roomDescription: String
	private(set) var description: String
	private(set) var tags: [String]
	private(set) var flags: ItemFlags

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.roomDescription = try container.decodeIfPresent(String.self, forKey: .roomDescription) ?? ""
		self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
		self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
		self.flags = try container.decodeIfPresent(ItemFlags.self, forKey: .flags) ?? .none
	}
}
