//

import Foundation

class Inventory {
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
		return true
	}

	func add(item: Item, quantity: Int) -> Int {
		guard !items.contains(where: { $0 === item }) else {
			return 0
		}

		if !item.definition.flags.contains(.noStack) {
			if let existing = items.first(where: { $0.definition.id == item.definition.id })  {
				existing.quantity += quantity
				return quantity
			}
		}

		let newItem = item.copy()
		newItem.quantity = quantity
		items.append(newItem)
		return quantity
	}

	func remove(item: Item, quantity: Int) -> Int {
		if item.quantity > quantity {
			item.quantity -= quantity
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

	func move(item: Item, quantity: Int, to inventory: Inventory) -> Int {
		let removed = remove(item: item, quantity: quantity)
		let added = inventory.add(item: item, quantity: removed)
		if removed != added {
			print("Something went wrong")
		}
		return removed
	}

	func copy(to inventory: Inventory) -> Int {
		return items
			.reduce(into: 0) { count, item in
				count += inventory.add(item: item, quantity: item.quantity)
			}
	}

	func transform(item: Item, into targetDef: ItemDefinition, count: Int) {
		let targetItem = Item(definition: targetDef)
		
		_ = add(item: targetItem)
		_ = remove(item: item, quantity: count)

		if let sourceInventory = item.inventory {
			if let targetInventory = targetItem.inventory {
				_ = sourceInventory.copy(to: targetInventory)
			} else {
				_ = sourceInventory.copy(to: self)
				// TODO: report
			}
		}
	}

	// MARK: - Finding Items
	func find(term: String) -> [Item] {
		return items
			.filter { item in
				Self.item(item, matches: term)
			}
	}

	func find(term: String, order: Int) -> Item? {
		return items
			.filter { item in
				Self.item(item, matches: term)
			}
			.dropFirst(order)
			.first
	}

	func findFirst(term: String) -> Item? {
		return items
			.first { item in
				Self.item(item, matches: term)
			}
	}

	// MARK: - Private Methods
	private static func item(_ item: Item, matches term: String) -> Bool {
		let term = term.lowercased()
		if item.definition.name
			.lowercased()
			.contains(term) {
			return true
		}

		if item.definition.tags
			.contains(where: { $0.lowercased().contains(term) }) {
			return true
		}
		
		return false
	}
}

extension Inventory {
	func find(token: CommandToken) -> Item? {
		return find(term: token.term, order: token.order)
	}
}
