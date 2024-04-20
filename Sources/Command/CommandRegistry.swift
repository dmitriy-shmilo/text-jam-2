//

import Foundation

class CommandRegistry {
	static let shared = CommandRegistry()

	private let commands = [
		HelpCommand(name: "help", articles: help),

		MoveCommand(name: "north", direction: .north),
		MoveCommand(name: "east", direction: .east),
		MoveCommand(name: "south", direction: .south),
		MoveCommand(name: "west", direction: .west),
		LookCommand(name: "look"),

		InventoryCommand(name: "inventory"),
		DropCommand(name: "drop"),
		TakeCommand(name: "take"),
		PutCommand(name: "put"),

		TillCommand(name: "till"),
		
		QuitCommand(name: "quit")
	]

	func command(for input: String) -> Command {
		guard let name = input.split(separator: " ").first?.lowercased() else {
			return InvalidCommand(name: "input")
		}
		return commands
			.first(where: {
				$0.name.hasPrefix(name)
			})
		?? InvalidCommand(name: name)
	}
}
