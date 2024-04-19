//

import Foundation

struct ItemRender {
	let oneLine: Bool
	let prefix: String
	let suffix: String

	func render(item: Item) {
		if oneLine {
			if item.quantity == 1 {
				colorPrint("\(prefix)\(item.definition.name)\(suffix)")
			}
			if item.quantity > 1 {
				colorPrint("\(prefix)\(item.definition.name)\(suffix) $w(\(item.quantity))")
			}
		}
	}
}

extension ItemRender {
	static let inventoryLineRender = ItemRender(
		oneLine: true, prefix: " $y-$* ", suffix: "")
	static let roomLineRender = ItemRender(
		oneLine: true, prefix: "$Y", suffix: " is on the ground.")
}
