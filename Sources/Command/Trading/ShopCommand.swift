//

import Foundation

class ShopCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let shop = ensureShop(in: player.currentRoom, in: world) else {
			return
		}

		let tokens = tokens(from: input)

		let filter = tokens[checked: 1]?.term ?? ""
		let resolver = PriceResolver(buyer: player)
		let shopRender = ShopRender(priceResolver: resolver)

		shopRender.render(shop: shop, filter: filter)
	}
}
