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

extension Shop {
	func find(token: CommandToken) -> Item? {
		if let index = Int(token.term), index > 0 && index <= inventory.items.count {
			return inventory.items[index - 1]
		}

		return inventory.find(token: token)
	}
}

// MARK: - ContainerEntity
extension Shop: ContainerEntity {
	var debugDescription: String {
		return "Shop(\(definition.id))"
	}
}
