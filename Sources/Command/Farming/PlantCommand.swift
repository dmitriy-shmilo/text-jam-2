//

import Foundation

class PlantCommand: Command {
	private static let growAction = "grow"
	private static let baseDuration = 15.0 * 60.0
	private static let baseEnergy = 0.08

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard let seedToken = tokens[checked: 1] else {
			print(commandFeedback: "Plant what?", padding: .bottom)
			return
		}

		guard let seed = ensure(seedToken, in: player) else {
			return
		}

		guard seed.definition.transformations[Self.growAction] != nil else {
			print(
				commandFeedback: "'\(seed.definition.name)' is not a seed.",
				padding: .bottom)
			return
		}

		guard let soilToken = tokens[checked: 2] else {
			print(commandFeedback: "Plant \(seed.definition.name) where?")
			return
		}

		guard let soil = ensure(soilToken, in: currentRoom) else {
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

		guard ensureEnough(
			time: Self.baseDuration,
			and: Self.baseEnergy,
			for: player,
			in: world) else {
			return
		}
		
		let moved = player.inventory.move(item: seed, quantity: 1, to: inventory, in: world)
		if moved != 1 {
			log(.warn, "Expected planting to move 1 seed into \(soil), but moved \(moved).")
		}
		print(commandFeedback: "You planted \(seed.definition.name) into \(soil.definition.name).")
	}
}
