//

import Foundation

class PeruseCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let shop = ensureShop(in: player.currentRoom, in: world) else {
			return
		}

		let tokens = tokens(from: input)
		guard let itemToken = tokens[checked: 1] else {
			print(commandFeedback: "Peruse what?")
			return
		}

		guard let item = shop.find(token: itemToken) else {
			print(commandFeedback: "'\(itemToken.term)' is not being sold here.")
			return
		}

		let priceResolver = PriceResolver(buyer: player)
		let price = priceResolver.purchasePrice(of: item)
		print(commandFeedback: "You take a closer look at \(item.definition.name).")
		ItemRender.detailsRender.render(item: item)
		colorPrint("$w\(item.definition.name) can be purchased for $W\(price)$Yc.")
	}
}
