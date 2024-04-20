//

import Foundation

class LookCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		if tokens.count == 1 {
			print(commandFeedback: "You look around.", padding: .none)
			RoomRender().render(room: currentRoom, limitItems: false)
			return
		}

		let token = tokens[1]
		// TODO: search among combined inventories
		if let item = currentRoom.inventory.find(term: token.term, order: token.order) {
			print(commandFeedback: "You look at \(item.definition.name).")
			ItemRender.detailsRender.render(item: item)
			return
		}

		if let item = player.inventory.find(term: token.term, order: token.order) {
			print(commandFeedback: "You look at \(item.definition.name).")
			ItemRender.detailsRender.render(item: item)
			return
		}

		print(commandFeedback: "You don't see '\(token.term)' here.")
	}
}
