//

import Foundation

struct InventoryRender {
	func render(inventory: Inventory) {
		colorPrint("$wYou check your backpack:")
		if inventory.items.isEmpty {
			colorPrint(" $y-$* Nothing")
			print()
			return
		}

		for item in inventory.items {
			ItemRender.inventoryLineRender.render(item: item)
		}
		print()
	}
}
