//

import Foundation

class Item {
	let definition: ItemDefinition
	var quantity: Int = 1

	init(definition: ItemDefinition) {
		self.definition = definition
	}
}
