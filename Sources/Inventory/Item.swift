//

import Foundation

class Item {
	static let infinite = Int.max

	weak var parent: Inventory?
	let inventory: Inventory?
	let definition: ItemDefinition
	var transformations = [ItemTransformation: TransformationProgress]()
	var quantity: Int = 1

	init(definition: ItemDefinition) {
		self.definition = definition
		if definition.flags.contains(.container) {
			inventory = .init()
			inventory?.parent = self
		} else {
			inventory = nil
		}
	}

	convenience init(definition: ItemDefinition, quantity: Int) {
		self.init(definition: definition)
		self.quantity = quantity
	}

	func copy(in world: World) -> Item {
		let item = world.spawn(item: definition, count: 1)
		item.transformations = transformations
		item.parent = parent
		return item
	}

	// MARK: - Transform
	func can(transform: ItemTransformation, inside container: Item?) -> Bool {
		guard container?.definition.id == transform.containerId || transform.containerId == nil else {
			return false
		}

		let contents = (inventory?.items ?? []).map { $0.definition.id }

		guard transform.contents == nil || transform.contents == contents else {
				return false
		}
		return true
	}

	func can(transform action: String, inside container: Item?) -> Bool {
		guard let transform = definition.transformations[action] else {
			return false
		}
		return can(transform: transform, inside: container)
	}

	func progress(transform: ItemTransformation, by step: Float) -> Bool {
		let progress = transformations[transform]?.progress(byAddingStep: step) ?? .init(progress: step)
		transformations[transform] = progress
		return progress.progress.isGreaterThanOrEqualWithinTolerance(to: 1.0)
	}
}

extension Item {
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
extension Item: ContainerEntity {

}

// MARK: - CustomDebugStringConvertible
extension Item: CustomDebugStringConvertible {
	var debugDescription: String {
		get {
			return "\(quantity) x \(definition.name)(\(definition.id))"
		}
	}
}
