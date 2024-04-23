//

import Foundation

class Player: Entity {
	var money = 0
	var energy: Float = 1.0
	let inventory: Inventory

	override init() {
		inventory = Inventory()
		super.init()
		inventory.parent = self
	}
}

// MARK: - ContainerEntity
extension Player: ContainerEntity {
	var debugDescription: String {
		return "player"
	}
}

