//

import Foundation

class PlantCommand: Command {
	private static let growAction = "grow"

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Plant what?", padding: .bottom)
			return
		}

		let seedToken = tokens[1]
		guard let seed = player.inventory.find(token: seedToken) else {
			print(commandFeedback: "You don't have \(seedToken.term)'.")
			return
		}

		guard seed.definition.transformations[Self.growAction] != nil else {
			print(
				commandFeedback: "'\(seed.definition.name)' is not a seed.",
				padding: .bottom)
			return
		}

		guard tokens.count > 2 else {
			print(commandFeedback: "Plant \(seed.definition.name) where?")
			return
		}

		let soilToken = tokens[2]
		guard let soil = currentRoom.inventory.find(token: soilToken) else {
			print(commandFeedback: "There's no \(soilToken.term)' here.")
			return
		}

		// TODO: check if soil is appropriate
		guard let inventory = soil.inventory else {
			print(commandFeedback: "You can't plant \(seed.definition.name) into \(soil.definition.name).", padding: .bottom)
			return
		}

		guard inventory.isEmpty else {
			print(commandFeedback: "\(soil.definition.name) is occupied already. Uproot its contents first.", padding: .bottom)
			return
		}

		let moved = player.inventory.move(item: seed, quantity: 1, to: inventory, in: world)
		if moved != 1 {
			log(.warn, "Expected planting to move 1 seed into \(soil), but moved \(moved).")
		}
		print(commandFeedback: "You planted \(seed.definition.name) into \(soil.definition.name).")
	}
}
