//

import Foundation

class LookCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard let token = tokens[checked: 1] else {
			print(commandFeedback: "You look around.", padding: .none)
			RoomRender().render(room: currentRoom, limitItems: false)
			return
		}

		// TODO: search among combined inventories
		let items = currentRoom.inventory
			.find(term: token.term)
		+ player.inventory
			.find(term: token.term)

		if items.count > token.order {
			let item = items[token.order]
			print(commandFeedback: "You look at \(item.definition.name).")
			ItemRender.detailsRender.render(item: item)
			return
		}

		if let actor = currentRoom.findActor(term: token.term, order: token.order - items.count) {
			print(commandFeedback: "You look at \(actor.definition.name).")
			ActorRender.detailsRender.render(actor: actor)
			return
		}

		print(commandFeedback: "You don't see '\(token.term)' here.")
	}
}
