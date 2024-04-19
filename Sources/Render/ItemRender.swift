//

import Foundation

struct ItemRender {
	let oneLine: Bool
	let preferRoomDescription: Bool
	let prefix: String
	let suffix: String

	func render(item: Item) {
		if !oneLine && !item.definition.description.isEmpty {
			colorPrint(item.definition.description)
			print()
			return
		}

		if preferRoomDescription && !item.definition.roomDescription.isEmpty {
			colorPrint(item.definition.roomDescription)
			return
		}


		if item.quantity == 1 {
			colorPrint("\(prefix)\(item.definition.name)\(suffix)")
		}

		if item.quantity > 1 {
			colorPrint("\(prefix)\(item.definition.name)\(suffix) $w(\(item.quantity))")
		}
	}
}

extension ItemRender {
	static let inventoryLineRender = ItemRender(
		oneLine: true, preferRoomDescription: false, prefix: " $y-$* ", suffix: "")
	static let roomLineRender = ItemRender(
		oneLine: true, preferRoomDescription: true, prefix: "$Y", suffix: " $Yis on the ground.")
	static let detailsRender = ItemRender(oneLine: false, preferRoomDescription: true, prefix: "", suffix: "")
}
