//

import Foundation

class InventoryCommand: Command {
	let playerInventoryRender = InventoryRender()
	override func execute(input: String, in world: World, by player: Player) {
		let tokens = tokens(from: input)
		print(commandFeedback: "You check your backpack:")
		if tokens.count > 1 {
			playerInventoryRender.render(items: player.inventory.find(term: tokens[1]))
			return
		}

		playerInventoryRender.render(inventory: player.inventory)
	}
}
