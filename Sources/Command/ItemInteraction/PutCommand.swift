//

import Foundation

class PutCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard let itemToken = tokens[checked: 1] else {
			print(commandFeedback: "Put what and where?", padding: .bottom)
			return
		}

		guard let item = ensure(itemToken, in: player) else {
			return
		}

		guard let containerToken = tokens[checked: 2] else {
			print(
				commandFeedback: "Put \(item.definition.name) where?",
				padding: .bottom)
			return
		}

		guard let container = ensure(containerToken, in: currentRoom) else {
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
			to: inventory,
			in: world)
		if moved > 0 {
			print(
				commandFeedback: "You put \(moved) x \(item.definition.name) in \(container.definition.name)",
				padding: .bottom)
		}
	}
}
