//

import Foundation

class TakeCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Take what?")
			print()
			return
		}

		guard let item = currentRoom.inventory.findFirst(term: tokens[1]) else {
			print(commandFeedback: "There's no '\(tokens[1])' around.")
			print()
			return
		}

		if player.inventory.add(item: item) && currentRoom.inventory.remove(item: item) {
			print(commandFeedback: "You take \(item.definition.name).")
			print()
		}

		// TODO: take from a container
	}
}
