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

	// MARK: - Private Methods
	private func take(
		_ itemToken: CommandToken,
		from containerToken: CommandToken,
		in room: Room,
		by player: Player
	) {
		guard let container = room.inventory
			.find(
				term: containerToken.term,
				order: containerToken.order) ?? player.inventory
			.find(term: containerToken.term, order: containerToken.order) else {
			print(
				commandFeedback: "There's no '\(containerToken.term)' around.",
				padding: .bottom)
			return
		}

		guard let inventory = container.inventory,
			  !container.definition.flags.contains(.noInteract) else {
			print(
				commandFeedback: "You can't take anything from \(container.definition.name).",
				padding: .bottom)
			return
		}

		guard let item = inventory
			.find(
				term: itemToken.term,
				order: itemToken.order) else {
			print(
				commandFeedback: "\(container.definition.name) doesn't have \(itemToken.term)",
				padding: .bottom)
			return
		}

		let moved = inventory.move(
			item: item,
			quantity: itemToken.quantity,
			to: player.inventory)

		if moved > 0 {
			print(
				commandFeedback: "You take \(moved) x \(item.definition.name) from \(container.definition.name).",
				padding: .bottom)
		}
	}

	private func take(
		_ itemToken: CommandToken,
		from room: Room,
		by player: Player
	) {
		guard let item = room.inventory
			.find(
				term: itemToken.term,
				order: itemToken.order) else {
			print(
				commandFeedback: "There's no '\(itemToken.term)' around.",
				padding: .bottom)
			return
		}

		guard !item.definition.flags.contains(.noPickup) else {
			print(
				commandFeedback: "You can't take \(item.definition.name).",
				padding: .bottom)
			return
		}

		let moved = room.inventory.move(
			item: item,
			quantity: itemToken.quantity,
			to: player.inventory)
		if moved > 0 {
			print(
				commandFeedback: "You pick up \(moved) x \(item.definition.name).",
				padding: .bottom)
		}
	}
}
