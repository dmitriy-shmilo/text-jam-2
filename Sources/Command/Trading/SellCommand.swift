//

import Foundation

class SellCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let shop = ensureShop(in: player.currentRoom, in: world) else {
			return
		}

		let tokens = tokens(from: input)
		guard let itemToken = tokens[checked: 1] else {
			print(commandFeedback: "Sell what?", padding: .bottom)
			return
		}

		guard let item = ensure(itemToken, in: player) else {
			return
		}

		let resolver = PriceResolver(buyer: player)
		let price = resolver.salePrice(of: item, quantity: itemToken.quantity)

		guard shop.definition.buyTags
			.contains(where: { item.definition.tags.contains($0) }),
			  price > 0 else {
			print(commandFeedback: "Shopkeep is not interested in \(item.definition.name).")
			return
		}

		colorPrint("$DYou sold \(item.definition.name) $Dfor $W\(price)$Yc$w.")
		player.money += price
		guard player.inventory.move(item: item, quantity: itemToken.quantity, to: shop.inventory, in: world) == itemToken.quantity else {
			log(.warn, "Incorrect amount sold.")
			return
		}
	}
}
