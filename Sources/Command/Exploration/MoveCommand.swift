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
			print(commandFeedback: "You can't move \(direction.localizedName)!")
			return
		}

		let oldAreas = Set(currentRoom.definition.exits.all.compactMap { $0?.areaId })
			.union([ currentRoom.areaId ])
		let newAreas = Set(targetRoom.definition.exits.all.compactMap { $0?.areaId })
			.union([ targetRoom.areaId ])

		let obscuredAreas = oldAreas.subtracting(newAreas)
		let discoveredAreas = newAreas.subtracting(oldAreas)


		discoveredAreas
			.forEach {
				world.areaDiscovered(id: $0)
			}

		_ = world.advanceTime(by: 60.0)
		print(commandFeedback: "You move \(direction.localizedName).")

		player.currentRoom = targetRef
		let render = RoomRender()
		render.render(room: targetRoom, limitItems: true)

		obscuredAreas
			.forEach {
				world.areaObscured(id: $0)
			}
	}
}
