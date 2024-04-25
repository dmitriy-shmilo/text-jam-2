//

import Foundation

class TillCommand: Command {
	private static let transformationAction = "till"
	private static let baseDuration = 30.0 * 60.0
	private static let baseEnergy = 0.13

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

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

		guard let toolToken = tokens[checked: 2] else {
			print(commandFeedback: "Till with what?", padding: .bottom)
			return
		}

		guard let tool = ensure(toolToken, in: player) else {
			return
		}

		guard let action = tool.definition.actions["till"] else {
			print(commandFeedback: "You can't till with \(tool.definition.name).")
			return
		}

		guard ensureEnough(
			time: Self.baseDuration * action.energyMultiplierOrDefault,
			and: Self.baseEnergy * action.energyMultiplierOrDefault,
			for: player,
			in: world) else {
			return
		}
		
		currentRoom.inventory.transform(item: item, into: targetItemDef, in: world)
		print(commandFeedback: "You till \(item.definition.name).", padding: .bottom)
	}
}
