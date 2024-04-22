//

import Foundation

class Inventory {
	weak var parent: ContainerEntity? = nil	
	private (set) var items = [Item]()
	var visibleItems: [Item] {
		items.filter { !$0.definition.flags.contains(.noList) }
	}
	var isEmpty: Bool {
		return items.isEmpty
	}

	// MARK: - Moving Items
	func add(item: Item) -> Bool {
		guard !items.contains(where: { $0 === item }) else {
			return false
		}
		items.append(item)
		item.parent = self
		return true
	}

	func add(item: Item, quantity: Int, in world: World) -> Int {
		guard !items.contains(where: { $0 === item }) else {
			return 0
		}

		if !item.definition.flags.contains(.noStack) {
			if let existing = items.first(where: { $0.definition.id == item.definition.id })  {
				if existing.quantity != Item.infinite {
					existing.quantity += quantity
				}
				return quantity
			}
		}

		guard quantity != Item.infinite else {
			log(.warn, "Prevented attempt to add an infinite amount of nostack items.")
			return 0
		}

		for _ in 0..<quantity {
			let newItem = item.copy(in: world)
			newItem.quantity = 1
			newItem.parent = self
			items.append(newItem)
		}
		return quantity
	}

	func remove(item: Item, quantity: Int) -> Int {
		if item.quantity > quantity {
			if item.quantity != Item.infinite {
				item.quantity -= quantity
			}
			return quantity
		}

		let count = item.quantity
		items
			.removeAll {
				$0 === item
			}
		return count
	}

	func removeAll() -> Int {
		let removed = items
			.reduce(into: 0, { res, item in
				res += item.quantity
			})
		items.removeAll()
		return removed
	}

	func move(item: Item, quantity: Int, to inventory: Inventory, in world: World) -> Int {
		// TODO: prevent unnecessary item copying
		let removed = remove(item: item, quantity: quantity)
		let added = inventory.add(item: item, quantity: removed, in: world)
		assert(removed == added)
		return removed
	}

	func forceMove(items: [Item], to inventory: Inventory) {
		inventory.items.append(contentsOf: items)
		inventory.items.forEach { $0.parent = inventory }
	}

	func copy(to inventory: Inventory, in world: World) -> Int {
		return items
			.reduce(into: 0) { count, item in
				count += inventory.add(item: item, quantity: item.quantity, in: world)
			}
	}

	func transform(
		item: Item,
		into targetDef: ItemDefinition,
		in world: World,
		movingTo receiverInventory: Inventory? = nil
	) {
		log(.debug, "transform \(item) to \(targetDef)", context: "\(self)")
		let targetItem = world.spawn(
			item: targetDef,
			in: receiverInventory ?? self,
			count: 1)
		_ = remove(item: item, quantity: 1)

		if let sourceInventory = item.inventory {
			if let targetInventory = targetItem.inventory {
				sourceInventory.forceMove(
					items: sourceInventory.items,
					to: targetInventory)
			} else {
				sourceInventory.forceMove(
					items: sourceInventory.items,
					to: receiverInventory ?? self)
				// TODO: report
			}
		}
	}

	// MARK: - Finding Items
	func find(term: String) -> [Item] {
		return items
			.filter { item in
				item.matches(filter: term)
			}
	}

	func find(term: String, order: Int) -> Item? {
		return items
			.filter { item in
				item.matches(filter: term)
			}
			.dropFirst(order)
			.first
	}

	func findFirst(term: String) -> Item? {
		return items
			.first { item in
				item.matches(filter: term)
			}
	}
}

extension Inventory {
	func find(token: CommandToken) -> Item? {
		return find(term: token.term, order: token.order)
	}
}

// MARK: - CustomDebugStringConvertible
extension Inventory: CustomDebugStringConvertible {
	var debugDescription: String {
		return "\(parent?.debugDescription ?? "") inventory"
	}
}
