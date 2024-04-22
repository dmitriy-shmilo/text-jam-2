//

import Foundation

class Command {
	let name: String

	init(name: String) {
		self.name = name
	}

	func execute(input: String, in world: World, by player: Player) {
		fatalError("Not implemented")
	}

	func tokens(from input: String) -> [CommandToken] {
		// TODO: support quotation marks
		let spacedStrings = input
			.split(separator: " ")
			.filter {
				!$0.isEmpty
			}
			.map {
				$0.lowercased()
			}

		return spacedStrings
			.map { str in
				let countParts = str.split(separator: "*")
				if countParts.count == 2, let count = Int(countParts[0]), count > 0 {
					return CommandToken(term: String(countParts[1]), quantity: count, order: 0)
				}

				let orderParts = str.split(separator: ".")
				if orderParts.count == 2, let order = Int(orderParts[0]), order > 0 {
					return CommandToken(term: String(orderParts[1]), quantity: 1, order: order - 1)
				}

				return CommandToken(term: str, quantity: 1, order: 0)
			}
	}

	func ensure(_ token: CommandToken, in player: Player) -> Item? {
		guard let item = player.inventory.find(token: token) else {
			print(commandFeedback: "You don't have '\(token.term)'.", padding: .bottom)
			return nil
		}
		return item
	}

	func ensure(_ token: CommandToken, in room: Room) -> Item? {
		guard let item = room.inventory.find(token: token) else {
			print(commandFeedback: "There's no '\(token.term)' here.", padding: .bottom)
			return nil
		}
		return item
	}
}
