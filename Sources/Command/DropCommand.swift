//

import Foundation

class DropCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Drop what?")
			print()
			return
		}

		for token in tokens.dropFirst(1) {
			guard let item = player.inventory.findFirst(term: token) else {
				print(commandFeedback: "You don't have '\(token)'.")
				continue
			}

			if currentRoom.inventory.add(item: item)
				&& player.inventory.remove(item: item) {
				print(commandFeedback: "You drop '\(item.definition.name)'.")
			}
		}
		print()
	}
}
