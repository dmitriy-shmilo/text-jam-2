//

import Foundation

class Inventory {
	private (set) var items = [Item]()
	var visibleItems: [Item] {
		items.filter { !$0.definition.flags.contains(.noList) }
	}

	func add(item: Item) -> Bool {
		guard !items.contains(where: { $0 === item }) else {
			return false
		}
		items.append(item)
		return true
	}

	func remove(item: Item) -> Bool {
		let count = items.count
		items
			.removeAll {
				$0 === item
			}
		return count > items.count
	}

	func find(term: String) -> [Item] {
		return items
			.filter { item in
				Self.item(item, matches: term)
			}
	}

	func findFirst(term: String) -> Item? {
		return items.first { item in
			Self.item(item, matches: term)
		}
	}

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
