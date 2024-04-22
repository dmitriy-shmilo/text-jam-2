//

import Foundation

class WhereCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let area = world.areas[player.currentRoom.areaId] else {
			return
		}

		print(commandFeedback: "You're in \(area.name).")
	}
}
