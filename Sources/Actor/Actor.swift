//

import Foundation

class Actor: Entity {
	let inventory: Inventory

	override init() {
		inventory = Inventory()
		super.init()
		inventory.parent = self
	}
}

// MARK: - ContainerEntity
extension Actor: ContainerEntity {
}
