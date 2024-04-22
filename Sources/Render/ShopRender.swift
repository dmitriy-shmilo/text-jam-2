//

import Foundation

struct ShopRender {
	func render(shop: Shop) {
		let hBorder = "$g+\(String(repeating: "-", count: 3))+\(String(repeating: "-", count: 30))+\(String(repeating: "-", count: 10))+\(String(repeating: "-", count: 10))+"
		colorPrint(hBorder)
		colorPrint("$g|  $Y#$g|$*\("Name".padding(toLength: 30, withPad: " ", startingAt: 0))$g|     $*Price$g| $DAvailable$g|")
		colorPrint(hBorder)
		// TODO: render empty shop
		for item in shop.inventory.items.enumerated() {
			renderRow(index: item.offset, item: item.element)
		}
		colorPrint(hBorder)
	}

	func renderRow(index: Int, item: Item) {
		let index = String(index)
		let count = item.quantity != Item.infinite ? String(item.quantity) : "Unlimited"
		let price = String(Int(item.definition.basePrice))

		let formattedIndex = index.paddingLeft(toLenth: 3)
		let formattedName = item.definition.name.paddingRight(toLenth: 30)
		let formattedPrice = price.paddingLeft(toLenth: 9)
		let formattedCount = count.paddingLeft(toLenth: 10)
		colorPrint("$g|$Y\(formattedIndex)$g|$*\(formattedName)$g|$*\(formattedPrice)$Yc$g|$D\(formattedCount)$g|")
	}
}
