//

import Foundation

class BuyCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let shop = ensureShop(in: player.currentRoom, in: world) else {
			return
		}
		
		let tokens = tokens(from: input)
		guard let itemToken = tokens[checked: 1] else {
			print(commandFeedback: "Buy what?")
			return
		}

		guard let item = shop.find(token: itemToken) else {
			print(commandFeedback: "'\(itemToken.term)' is not being sold here.")
			return
		}

		guard item.quantity >= itemToken.quantity else {
			print(commandFeedback: "There's only \(item.quantity) \(item.definition.name) available.")
			return
		}

		let priceResolver = PriceResolver(buyer: player)
		let price = priceResolver.purchasePrice(of: item, quantity: itemToken.quantity)

		guard player.money >= price else {
			colorPrint("$DYou need $W\(price)$Yc$D to buy \(itemToken.quantity) x \(item.definition.name).")
			return
		}

		colorPrint("$DYou paid $W\(price)$Yc$D for \(itemToken.quantity) x \(item.definition.name).")

		guard shop.inventory.move(item: item, quantity: itemToken.quantity, to: player.inventory, in: world) == itemToken.quantity else {
			log(.warn, "Incorrect amount purchased.")
			return
		}
		player.money -= price
	}
}
