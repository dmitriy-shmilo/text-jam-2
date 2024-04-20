//

import Foundation

class TakeCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Take what?", padding: .bottom)
			return
		}

		if tokens.count > 2 {
			take(tokens[1], from: tokens[2], in: currentRoom, by: player)
			return
		}

		take(tokens[1], from: currentRoom, by: player)
	}

	private func take(_ itemName: String, from containerName: String, in room: Room, by player: Player) {
		guard let container = room.inventory.findFirst(term: containerName)
		?? player.inventory.findFirst(term: containerName) else {
			print(commandFeedback: "There's no '\(containerName)' around.", padding: .bottom)
			return
		}

		guard let inventory = container.inventory else {
			print(
				commandFeedback: "\(container.definition.name) is not a container.",
				padding: .bottom)
			return
		}

		guard let item = inventory.findFirst(term: itemName) else {
			print(
				commandFeedback: "\(container.definition.name) doesn't have \(itemName)",
				padding: .bottom)
			return
		}

		if player.inventory.add(item: item) && inventory.remove(item: item) {
			print(
				commandFeedback: "You take \(item.definition.name) from \(container.definition.name).",
				padding: .bottom)
		}
	}

	private func take(_ itemName: String, from room: Room, by player: Player) {
		guard let item = room.inventory.findFirst(term: itemName) else {
			print(
				commandFeedback: "There's no '\(itemName)' around.",
				padding: .bottom)
			return
		}

		guard !item.definition.flags.contains(.noPickup) else {
			print(
				commandFeedback: "You can't take \(item.definition.name).",
				padding: .bottom)
			return
		}

		if player.inventory.add(item: item) && room.inventory.remove(item: item) {
			print(
				commandFeedback: "You pick up \(item.definition.name).",
				padding: .bottom)
		}
	}
}
