//

import Foundation

class TillCommand: Command {
	private static let transformationAction = "till"

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		// TODO: check for the correct tool
		// TODO: time and energy cost

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Till what?", padding: .bottom)
			return
		}

		let token = tokens[1]
		guard let item = currentRoom.inventory.find(token: token) else {
			print(commandFeedback: "There's no '\(token.term)' here.")
			return
		}

		guard let transformation = item.definition.transformations.first(where: { $0.action == Self.transformationAction }),
			  let targetItemDef = itemDatabase[transformation.targetId] else {
			print(commandFeedback: "You can't till \(item.definition.name).")
			return
		}

		currentRoom.inventory.transform(item: item, into: targetItemDef, count: 1)
		print(commandFeedback: "You till \(item.definition.name).", padding: .bottom)
	}
}
