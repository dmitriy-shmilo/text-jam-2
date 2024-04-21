//

import Foundation

class QuitCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard input.lowercased() == name.lowercased() else {
			print(commandFeedback: "Type '\(name)' to exit without saving.")
			print()
			return
		}

		print(commandFeedback: "You've left the game.")
		print()
		exit(0)
	}
}
