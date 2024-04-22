//

import Foundation

struct ShopRender {
	let priceResolver: PriceResolver

	func render(shop: Shop, filter: String) {
		let hBorder = "$g+\(String(repeating: "-", count: 3))+\(String(repeating: "-", count: 30))+\(String(repeating: "-", count: 10))+\(String(repeating: "-", count: 10))+"
		colorPrint(hBorder)
		colorPrint("$g|  $Y#$g|$*\("Name".paddingRight(toLength: 30))$g|     $*Price$g|     $DStock$g|")
		colorPrint(hBorder)
		// TODO: render empty shop
		let items = shop.inventory.items
			.enumerated()
			.filter { $0.element.matches(filter: filter) }
		if items.isEmpty {
			colorPrint("$g|\(String(repeating: " ", count: 3))|$*\("Nothing".paddingRight(toLength: 30))$g|\(String(repeating: " ", count: 10))|\(String(repeating: " ", count: 10))|")
		} else {
			for item in items {
				renderRow(index: item.offset, item: item.element)
			}
		}
		colorPrint(hBorder)
	}

	func renderRow(index: Int, item: Item) {
		let index = String(index + 1)
		let count = item.quantity != Item.infinite ? String(item.quantity) : "Unlimited"
		let price = String(priceResolver.purchasePrice(of: item))

		let formattedIndex = index.paddingLeft(toLength: 3)
		let formattedName = item.definition.name.paddingRight(toLength: 30)
		let formattedPrice = price.paddingLeft(toLength: 9)
		let formattedCount = count.paddingLeft(toLength: 10)
		colorPrint("$g|$Y\(formattedIndex)$g|$*\(formattedName)$g|$*\(formattedPrice)$Yc$g|$D\(formattedCount)$g|")
	}
}
