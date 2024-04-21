//

import Foundation

struct AreaDefinition: Codable {
	let id: Int
	let name: String
	let rooms: [RoomDefinition]
	let defaultRoom: RoomRef
}

// MARK: - CustomDebugStringConvertible
extension AreaDefinition: CustomDebugStringConvertible {
	var debugDescription: String {
		return "\(name)(\(id))"
	}
}
