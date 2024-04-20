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
}
