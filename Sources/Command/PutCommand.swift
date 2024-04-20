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

		let itemToken = tokens[1]
		guard let item = player.inventory.find(term: itemToken.term, order: itemToken.order) else {
			print(commandFeedback: "You don't have '\(itemToken.term)'.", padding: .bottom)
			return
		}

		guard tokens.count > 2 else {
			print(
				commandFeedback: "Put \(item.definition.name) where?",
				padding: .bottom)
			return
		}

		let containerToken = tokens[2]
		guard let container = currentRoom.inventory.find(term: containerToken.term, order: containerToken.order) else {
			print(
				commandFeedback: "There's no '\(containerToken.term)' around.",
				padding: .bottom)
			return
		}

		guard let inventory = container.inventory else {
			print(
				commandFeedback: "\(container.definition.name) is not a container.",
				padding: .bottom)
			return
		}

		let moved = player.inventory.move(
			item: item,
			quantity: itemToken.quantity,
			to: inventory)
		if moved > 0 {
			print(
				commandFeedback: "You put \(moved) x \(item.definition.name) in \(container.definition.name)",
				padding: .bottom)
		}
	}
}
