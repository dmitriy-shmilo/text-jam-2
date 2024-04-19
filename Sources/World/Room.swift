//

import Foundation

class Room {
	let definition: RoomDefinition
	let inventory = Inventory()

	init(definition: RoomDefinition) {
		self.definition = definition
	}
}
