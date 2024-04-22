//

import Foundation

class ScanCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}
		
		print(commandFeedback: "You look around.")
		ScanRender().render(currentRoom: currentRoom, in: world)
	}
}
