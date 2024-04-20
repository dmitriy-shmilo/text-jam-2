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
				.compactMap { placedItem -> (ItemDefinition, Int)? in
					guard let container = placedItem.containerId,
						  let item = itemDatabase[placedItem.id] else {
						return nil
					}
					return (item, container)
				}
				.forEach { placedItem in
					guard let container = room.inventory.items.first(where: { $0.definition.id == placedItem.1 }) else {
						print("No container \(placedItem.1) in room \(room.definition.id)")
						return
					}

					guard let inventory = container.inventory else {
						print("Item \(placedItem.1) in room \(room.definition.id) doesn't have an inventory")
						return
					}

					guard inventory.add(item: Item(definition: placedItem.0)) else {
						print("Failed to add item \(placedItem.0) to a container \(placedItem.1) in room \(room.definition.id)")
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
