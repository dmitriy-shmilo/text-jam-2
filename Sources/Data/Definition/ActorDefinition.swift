//

import Foundation

struct ActorDefinitions: Codable {
	let actors: [ActorDefinition]
}

struct ActorDefinition {
	let id: Int
	let name: String
	let nouns: Set<String>
	let tags: Set<String>
	let roomDescription: String?
	let description: String?
}

extension ActorDefinition: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		nouns = try Set(container.decodeIfPresent([String].self, forKey: .nouns) ?? [])
		tags = try Set(container.decodeIfPresent([String].self, forKey: .tags) ?? [])
		roomDescription = try container.decodeIfPresent(String.self, forKey: .roomDescription)
		description = try container.decodeIfPresent(String.self, forKey: .description)
	}
}
