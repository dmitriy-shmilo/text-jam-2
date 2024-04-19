//

import Foundation

class MoveCommand: Command {
	let direction: Direction

	init(name: String, direction: Direction) {
		self.direction = direction
		super.init(name: name)
	}

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let targetRef = currentRoom.definition.exits[direction]

		guard let targetRoom = world.rooms[targetRef] else {
			colorPrint("You can't move \(direction.localizedName)!")
			return
		}

		colorPrint("You move \(direction.localizedName)...", filling: .darkWhite)

		player.currentRoom = targetRef
		let render = RoomRender()
		render.render(room: targetRoom)
	}
}
