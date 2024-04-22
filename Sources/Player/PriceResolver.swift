//

import Foundation

struct PriceResolver {
	let buyer: Player

	func preciseSalePrice(of item: Item) -> Float {
		return item.definition.basePrice * 0.75
	}

	func salePrice(of item: Item) -> Int {
		return Int(preciseSalePrice(of: item))
	}

	func precisePurchasePrice(of item: Item) -> Float {
		return max(item.definition.basePrice * 2.5, 2.0)
	}

	func purchasePrice(of item: Item) -> Int {
		return Int(precisePurchasePrice(of: item))
	}
}
