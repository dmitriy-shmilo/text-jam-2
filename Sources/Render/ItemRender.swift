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

	private func renderFullDescription(item: Item) {
		if !item.definition.description.isEmpty {
			colorPrint("\(item.definition.description) \(inventoryContents(item: item))")
		} else {
			renderRoomLine(item: item)
		}
		print()

		if let inventory = item.inventory {
			colorPrint("Contents:", filling: .darkWhite)
			InventoryRender().render(inventory: inventory)
		}
	}

	private func renderRoomLine(item: Item) {
		if preferRoomDescription && !item.definition.roomDescription.isEmpty {
			colorPrint("\(item.definition.roomDescription) \(inventoryContents(item: item))")
		} else {
			renderOneLine(item: item)
		}
	}

	private func renderOneLine(item: Item) {
		if item.quantity == 1 {
			colorPrint("\(prefix)\(item.definition.name)\(suffix)")
			return
		}

		if item.quantity > 1 {
			colorPrint("\(prefix)\(item.definition.name)\(suffix) $w(\(item.quantity))")
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

		if topItem.quantity == 1 {
			return "$w(\(topItem.definition.name)$w)"
		}

		return "$w(\(topItem.quantity) x \(topItem.definition.name)$w)"
	}
}

extension ItemRender {
	static let inventoryLineRender = ItemRender(
		oneLine: true, preferRoomDescription: false, previewContents: true, prefix: " $y-$* ", suffix: "")
	static let roomLineRender = ItemRender(
		oneLine: true, preferRoomDescription: true, previewContents: true, prefix: "$Y", suffix: " $Yis on the ground.")
	static let detailsRender = ItemRender(oneLine: false, preferRoomDescription: true, previewContents: false, prefix: "", suffix: "")
}
