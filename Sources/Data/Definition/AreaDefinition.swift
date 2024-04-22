//

import Foundation

struct AreaDefinition {
	let id: Int
	let name: String
	let rooms: [RoomDefinition]
	let shops: [ShopDefinition]
	let defaultRoom: RoomRef
}

extension AreaDefinition: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		defaultRoom = try container.decode(RoomRef.self, forKey: .defaultRoom)
		rooms = try container.decodeIfPresent([RoomDefinition].self, forKey: .rooms) ?? []
		shops = try container.decodeIfPresent([ShopDefinition].self, forKey: .shops) ?? []
	}
}
// MARK: - CustomDebugStringConvertible
extension AreaDefinition: CustomDebugStringConvertible {
	var debugDescription: String {
		return "\(name)(\(id))"
	}
}
