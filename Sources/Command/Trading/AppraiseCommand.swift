//

import Foundation

class AppraiseCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		guard let shop = world.shops[player.currentRoom] else {
			print(commandFeedback: "You're not in a shop.", padding: .bottom)
			return
		}

		let tokens = tokens(from: input)
		guard let itemToken = tokens[checked: 1] else {
			print(commandFeedback: "Appraise what?", padding: .bottom)
			return
		}

		guard let item = ensure(itemToken, in: player) else {
			return
		}

		let resolver = PriceResolver(buyer: player)
		let price = resolver.salePrice(of: item)
		// TODO: ensure a shopkeep actor

		guard shop.definition.buyTags
			.contains(where: { item.definition.tags.contains($0) }),
			  price > 0 else {
			print(commandFeedback: "Shopkeep is not interested in \(item.definition.name).")
			return
		}

		colorPrint("$wYou can sell \(item.definition.name) $wfor $W\(price)$Yc$w.")
	}
}
