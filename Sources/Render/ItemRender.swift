//

import Foundation

struct ItemRender {
	let oneLine: Bool
	let preferRoomDescription: Bool
	let previewContents: Bool
	let prefix: String
	let suffix: String

	func render(item: Item) {
		if !oneLine {
			renderFullDescription(item: item)
			return
		}

		renderRoomLine(item: item)
	}

	// MARK: - Private Methods
	private func renderFullDescription(item: Item) {
		guard let description = item.definition.description else {
			renderRoomLine(item: item)
			print()
			return
		}

		colorPrint("\(description) \(inventoryContents(item: item))")
		print()

		if let inventory = item.inventory {
			colorPrint("Contents:", filling: .black)
			InventoryRender().render(inventory: inventory)
		}
	}

	private func renderRoomLine(item: Item) {
		guard let description = item.definition.roomDescription, preferRoomDescription else {
			renderOneLine(item: item)
			return
		}
		colorPrint("\(prefix)\(description) \(inventoryContents(item: item))")
	}

	private func renderOneLine(item: Item) {
		if item.quantity == 1 || item.quantity == Item.infinite {
			colorPrint("\(prefix)\(item.definition.name)\(suffix)")
			return
		}

		if item.quantity > 1 {
			colorPrint("\(prefix)\(item.definition.name)\(suffix) $D(\(item.quantity))")
			return
		}

		colorPrint("\(prefix)\(item.definition.name)\(suffix) $R(\(item.quantity))")
	}

	private func inventoryContents(item: Item) -> String {
		guard previewContents,
			  item.quantity == 1,
			  let inventory = item.inventory,
			  inventory.items.count == 1,
			  let topItem = inventory.visibleItems.first,
			  topItem.quantity > 0 else {
			return ""
		}

		if topItem.quantity == 1 || topItem.quantity == Item.infinite {
			return "$D(\(topItem.definition.name)$D)"
		}

		return "$D(\(topItem.quantity) x \(topItem.definition.name)$D)"
	}
}

extension ItemRender {
	static let inventoryLineRender = ItemRender(
		oneLine: true, preferRoomDescription: false, previewContents: true, prefix: " $y-$* ", suffix: "")
	static let roomLineRender = ItemRender(
		oneLine: true, preferRoomDescription: true, previewContents: true, prefix: "$w", suffix: " $wis on the ground.")
	static let detailsRender = ItemRender(oneLine: false, preferRoomDescription: true, previewContents: false, prefix: "", suffix: "")
}
