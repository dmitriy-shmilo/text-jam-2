//

import Foundation

struct InventoryRender {
	func render(inventory: Inventory) {
		render(items: inventory.items)
	}

	func render(items: [Item]) {
		if items.isEmpty {
			colorPrint(" $y-$* Nothing")
			print()
			return
		}

		for item in items {
			ItemRender.inventoryLineRender.render(item: item)
		}
		print()
	}
}
