//

import Foundation

class LookCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let parts = tokens(from: input)
		if parts.count == 1 {
			print(commandFeedback: "You look around and see.")
			RoomRender().render(room: currentRoom, limitItems: false)
			return
		}

		let term = parts[1]
		if let item = currentRoom.inventory.findFirst(term: term) {
			print(commandFeedback: "You look at \(item.definition.name).")
			ItemRender.detailsRender.render(item: item)
			return
		}

		if let item = player.inventory.findFirst(term: term) {
			print(commandFeedback: "You look at \(item.definition.name).")
			ItemRender.detailsRender.render(item: item)
			return
		}

		print(commandFeedback: "You don't see '\(term)' here.")
	}
}
