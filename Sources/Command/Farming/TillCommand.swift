//

import Foundation

class TillCommand: Command {
	private static let transformationAction = "till"
	private static let baseDuration = 30.0 * 60.0

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		// TODO: check for the correct tool
		// TODO: time and energy cost

		let tokens = tokens(from: input)
		guard let token = tokens[checked: 1] else {
			print(commandFeedback: "Till what?", padding: .bottom)
			return
		}

		guard let item = ensure(token, in: currentRoom) else {
			return
		}

		guard let transformation = item.definition.transformations[Self.transformationAction],
			  let targetItemDef = itemDatabase[transformation.targetId] else {
			print(commandFeedback: "You can't till \(item.definition.name).")
			return
		}

		guard ensureEnough(
			time: Self.baseDuration,
			and: 0.0,
			for: player,
			in: world) else {
			return
		}
		
		currentRoom.inventory.transform(item: item, into: targetItemDef, in: world)
		print(commandFeedback: "You till \(item.definition.name).", padding: .bottom)
	}
}
