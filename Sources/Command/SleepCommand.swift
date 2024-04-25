//

import Foundation

class SleepCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		guard let targetItem = currentRoom.inventory
			.items
			.first(where: {
				$0.definition.actions.first(where: { $0.name == "sleep" }) != nil
			}) else {
			print(commandFeedback: "There's no bed to sleep in.")
			return
		}
		print(commandFeedback: "You sleep in \(targetItem.definition.name).")
		player.energy = 1.0
		world.dayPass()
		print(commandFeedback: "You had a good night sleep, your energy is recovered.")
		SaveManager().save(world: world)
		print(commandFeedback: "Your game is saved.")
	}
}
