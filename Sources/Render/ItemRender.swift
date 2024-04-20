//

import Foundation

struct ItemRender {
	let oneLine: Bool
	let preferRoomDescription: Bool
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
			colorPrint(item.definition.description)
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
			colorPrint(item.definition.roomDescription)
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
}

extension ItemRender {
	static let inventoryLineRender = ItemRender(
		oneLine: true, preferRoomDescription: false, prefix: " $y-$* ", suffix: "")
	static let roomLineRender = ItemRender(
		oneLine: true, preferRoomDescription: true, prefix: "$Y", suffix: " $Yis on the ground.")
	static let detailsRender = ItemRender(oneLine: false, preferRoomDescription: true, prefix: "", suffix: "")
}
