//

import Foundation

class PutCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Put what and where?", padding: .bottom)
			return
		}

		guard let item = player.inventory.findFirst(term: tokens[1]) else {
			print(commandFeedback: "You don't have '\(tokens[1])'.", padding: .bottom)
			return
		}

		guard tokens.count > 2 else {
			print(
				commandFeedback: "Put \(item.definition.name) where?",
				padding: .bottom)
			return
		}

		guard let container = currentRoom.inventory.findFirst(term: tokens[2]) else {
			print(
				commandFeedback: "There's no '\(tokens[2])' around.",
				padding: .bottom)
			return
		}

		guard let inventory = container.inventory else {
			print(
				commandFeedback: "\(container.definition.name) is not a container.",
				padding: .bottom)
			return
		}

		if inventory.add(item: item) && player.inventory.remove(item: item) {
			print(
				commandFeedback: "You put \(item.definition.name) in \(container.definition.name)",
				padding: .bottom)
		}
	}
}
