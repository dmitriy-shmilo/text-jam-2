//

import Foundation

class SleepCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		world.dayPass()
		SaveManager().save(world: world)
	}
}
