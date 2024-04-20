//

import Foundation

class Item {
	let inventory: Inventory?
	let definition: ItemDefinition
	var quantity: Int = 1

	init(definition: ItemDefinition) {
		self.definition = definition
		if definition.flags.contains(.container) {
			inventory = .init()
		} else {
			inventory = nil
		}
	}

	convenience init(definition: ItemDefinition, quantity: Int) {
		self.init(definition: definition)
		self.quantity = quantity
	}

	func copy() -> Item {
		let item = Item(definition: definition)
		item.quantity = quantity
		return item
	}
}
