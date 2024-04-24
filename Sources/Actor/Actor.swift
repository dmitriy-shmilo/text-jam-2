//

import Foundation

class Actor: Entity {
	let id: Int
	let definition: ActorDefinition
	let inventory: Inventory

	init(id: Int, definition: ActorDefinition) {
		self.id = id
		self.definition = definition
		inventory = Inventory()
		super.init()

		inventory.parent = self
	}
}

extension Actor {
	func matches(filter: String) -> Bool {
		let term = filter.lowercased()
		guard !term.isEmpty else {
			return true
		}

		if definition.name
			.lowercased()
			.hasPrefix(term) {
			return true
		}

		if definition.nouns
			.contains(where: { $0.lowercased().hasPrefix(term) }) {
			return true
		}

		if definition.tags
			.contains(where: { $0.lowercased().hasPrefix(term) }) {
			return true
		}

		return false
	}
}

// MARK: - ContainerEntity
extension Actor: ContainerEntity {
	var debugDescription: String {
		return "actor \(definition.name)(\(id))"
	}
}
