//

import Foundation

class Room {
	let areaId: Int
	let definition: RoomDefinition
	let inventory = Inventory()

	init(areaId: Int, definition: RoomDefinition) {
		self.areaId = areaId
		self.definition = definition
		inventory.parent = self
	}
}

// MARK: - ContainerEntity
extension Room: ContainerEntity {
	var debugDescription: String {
		return "\(definition.name)(\(definition.id))"
	}
}
