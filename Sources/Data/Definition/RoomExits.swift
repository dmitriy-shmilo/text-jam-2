//

import Foundation

struct RoomExits: Codable {
	var north: RoomRef?
	var south: RoomRef?
	var east: RoomRef?
	var west: RoomRef?
}

extension RoomExits {
	var all: [RoomRef?] {
		return [north, east, south, west]
	}

	var valid: [RoomRef] {
		return all.compactMap {
			guard let r = $0, r != .invalid else {
				return nil
			}
			return $0
		}
	}

	subscript(direction: Direction) -> RoomRef {
		get {
			switch direction {
			case .north:
				return north ?? .invalid
			case .east:
				return east ?? .invalid
			case .south:
				return south ?? .invalid
			case .west:
				return west ?? .invalid
			}
		}
	}
}
