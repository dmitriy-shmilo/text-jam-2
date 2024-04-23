//

import Foundation

class Room {
	let areaId: Int
	let definition: RoomDefinition
	let inventory = Inventory()
	private (set) var actors = [Actor]()

	init(areaId: Int, definition: RoomDefinition) {
		self.areaId = areaId
		self.definition = definition
		inventory.parent = self
	}

	func add(actor: Actor) {
		guard !actors.contains(where: { $0 === actor }) else {
			log(.warn, "Prevented adding a duplicate actor to a room")
			return
		}
		actor.currentRoom = roomRef
		actors.append(actor)
	}

	func findActor(term: String, order: Int) -> Actor? {
		return actors
			.filter { actor in
				actor.matches(filter: term)
			}
			.dropFirst(order)
			.first
	}
}

extension Room {
	var roomRef: RoomRef {
		return .init(id: definition.id, areaId: areaId)
	}
}

// MARK: - ContainerEntity
extension Room: ContainerEntity {
	var debugDescription: String {
		return "\(definition.name)(\(definition.id))"
	}
}
