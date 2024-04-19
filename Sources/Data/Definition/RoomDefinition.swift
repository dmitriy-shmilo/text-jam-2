//

import Foundation

struct RoomRef: Codable, Hashable {
	let id: Int
	let areaId: Int
}

extension RoomRef {
	static let invalid = RoomRef(id: -1, areaId: -1)
}

struct RoomDefinition: Codable {
	let id: Int
	let name: String
	let description: String
	var exits: RoomExits
}
