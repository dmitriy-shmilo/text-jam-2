//

import Foundation

class Inventory {
	private (set) var items = [Item]()

	func add(item: Item) {
		guard !items.contains(where: { $0 === item }) else {
			return
		}
		items.append(item)
	}
}
