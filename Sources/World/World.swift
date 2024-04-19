//

import Foundation

class World {
	var areas = [Int: AreaDefinition]()
	var rooms = [RoomRef: Room]()
	let player: Player

	init(player: Player) {
		self.player = player
	}

	func load(area: AreaDefinition) {
		areas[area.id] = area
		for room in area.rooms {
			rooms[.init(id: room.id, areaId: area.id)] = .init(definition: room)
		}
	}

	func unload(areaId: Int) {
		guard let area = areas[areaId] else {
			return
		}

		for room in area.rooms {
			rooms.removeValue(forKey: .init(id: room.id, areaId: area.id))
		}
	}
}
