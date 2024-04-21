//

import Foundation

class Room {
	let definition: RoomDefinition
	let inventory = Inventory()

	init(definition: RoomDefinition) {
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
