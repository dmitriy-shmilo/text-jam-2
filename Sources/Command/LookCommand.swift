//

import Foundation

class LookCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let parts = input.split(separator: " ").filter { !$0.isEmpty }
		if parts.count == 1 {
			colorPrint("You look around and see...", filling: .darkWhite)
			RoomRender().render(room: currentRoom)
			return
		}

		// TODO: look up entity
	}
}
