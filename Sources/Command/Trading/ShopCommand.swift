//

import Foundation

class ShopCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		guard let shop = world.shops[player.currentRoom] else {
			print(commandFeedback: "You're not in a shop.", padding: .bottom)
			return
		}

		let tokens = tokens(from: input)

		let filter = tokens[checked: 1]?.term ?? ""
		let resolver = PriceResolver(buyer: player)
		let shopRender = ShopRender(priceResolver: resolver)

		shopRender.render(shop: shop, filter: filter)
	}
}
