//

import Foundation

class DropCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Drop what?", padding: .bottom)
			return
		}

		for token in tokens.dropFirst(1) {
			guard let item = player.inventory.find(term: token.term, order: token.order) else {
				print(commandFeedback: "You don't have '\(token.term)'.")
				continue
			}

			let removed = player.inventory.move(
				item: item,
				quantity: token.quantity,
				to: currentRoom.inventory)
			if removed > 0 {
				print(commandFeedback: "You drop \(removed) x \(item.definition.name).", padding: .none)
			}
		}
		print()
	}
}
