//

import Foundation

class World {
	var shouldQuit = false
	var areas = [Int: AreaDefinition]()
	var rooms = [RoomRef: Room]()
	var currentTime = Time(hours: 7, minutes: 0)

	let player: Player

	init(player: Player) {
		self.player = player
	}

	func load(area: AreaDefinition) {
		areas[area.id] = area
		for roomDef in area.rooms {
			let room = Room(definition: roomDef)
			roomDef.placedItems
				.filter { $0.containerId == nil }
				.compactMap { itemDatabase[$0.id] }
				.map { Item(definition: $0) }
				.forEach { item in
					_ = room.inventory.add(item: item)
				}

			roomDef.placedItems
				.forEach { placedItem in
					guard let containerId = placedItem.containerId else {
						// placed on the first pass
						return
					}

					guard let itemDef = itemDatabase[placedItem.id] else {
						print("No item \(placedItem.id) in the database.")
						return
					}
					
					// TODO: support container order
					guard let container = room.inventory.items.first(where: { $0.definition.id == containerId }) else {
						print("No container \(containerId) in room \(room.definition.id)")
						return
					}

					guard let inventory = container.inventory else {
						print("Item \(container.definition.id) in room \(room.definition.id) doesn't have an inventory")
						return
					}

					guard inventory.add(item: Item(definition: itemDef, quantity: placedItem.count ?? 1)) else {
						print("Failed to add item \(placedItem.id) to a container \(container.definition.id) in room \(room.definition.id)")
						return
					}
				}
			rooms[.init(id: roomDef.id, areaId: area.id)] = room
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
