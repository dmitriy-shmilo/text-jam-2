//

import Foundation

struct ItemDefinitions: Codable {
	let items: [ItemDefinition]
}

// MARK: - Codable
struct ItemDefinition: Codable {
	let id: Int
	let name: String
	let roomDescription: String
	let description: String
	let tags: [String]
	let flags: ItemFlags
	let transformations: [ItemTransformation]
	let capacity: Int
	let basePrice: Float

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		roomDescription = try container.decodeIfPresent(String.self, forKey: .roomDescription) ?? ""
		description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
		tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
		flags = try container.decodeIfPresent(ItemFlags.self, forKey: .flags) ?? .none
		transformations = try container.decodeIfPresent(
			[ItemTransformation].self,
			forKey: .transformations) ?? []
		capacity = try container.decodeIfPresent(Int.self, forKey: .capacity) ?? 1
		basePrice = try container.decodeIfPresent(Float.self, forKey: .basePrice) ?? 0.0
	}
}

// MARK: - CustomDebugStringConvertible
extension ItemDefinition: CustomDebugStringConvertible {
	var debugDescription: String {
		return "\(name)(def \(id))"
	}
}
