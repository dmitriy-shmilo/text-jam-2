//

import Foundation

class ShopCommand: Command {
	private let render = ShopRender()

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		guard let shop = world.shops[player.currentRoom] else {
			print(commandFeedback: "You're not in a shop.", padding: .bottom)
			return
		}

		render.render(shop: shop)
	}
}
