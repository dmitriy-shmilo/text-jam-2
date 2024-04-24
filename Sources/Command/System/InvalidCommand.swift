//

import Foundation

class InvalidCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		if !input.isEmpty {
			colorPrint("'$y\(name)$*' is not a valid action. See $Yhelp$* for a list of available commands.")
		}
		print()
	}
}
