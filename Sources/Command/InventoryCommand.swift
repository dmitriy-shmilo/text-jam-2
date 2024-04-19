//

import Foundation

class InventoryCommand: Command {
	let playerInventoryRender = InventoryRender()
	override func execute(input: String, in world: World, by player: Player) {
		let tokens = tokens(from: input)
		if tokens.count > 1 {
			// filter inventory
		}

		playerInventoryRender.render(inventory: player.inventory)
	}
}
