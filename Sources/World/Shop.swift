//

import Foundation

class Shop {
	let definition: ShopDefinition
	let inventory: Inventory

	init(definition: ShopDefinition) {
		self.definition = definition
		self.inventory = .init()
		inventory.parent = self
	}
}

// MARK: - ContainerEntity
extension Shop: ContainerEntity {
	var debugDescription: String {
		return "Shop(\(definition.id))"
	}
}
