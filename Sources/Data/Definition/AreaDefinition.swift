//

import Foundation

struct AreaDefinition {
	enum UnloadCondition: String, Codable {
		case never, leave, overnight
	}
	let id: Int
	let name: String
	let rooms: [RoomDefinition]
	let shops: [ShopDefinition]
	let defaultRoom: RoomRef?
	let unload: UnloadCondition
}

extension AreaDefinition: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		defaultRoom = try container.decodeIfPresent(RoomRef.self, forKey: .defaultRoom) ?? .invalid
		rooms = try container.decodeIfPresent([RoomDefinition].self, forKey: .rooms) ?? []
		shops = try container.decodeIfPresent([ShopDefinition].self, forKey: .shops) ?? []
		unload = try container.decodeIfPresent(UnloadCondition.self, forKey: .unload) ?? .overnight
	}
}
// MARK: - CustomDebugStringConvertible
extension AreaDefinition: CustomDebugStringConvertible {
	var debugDescription: String {
		return "\(name)(\(id))"
	}
}
