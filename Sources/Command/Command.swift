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

	func tokens(from input: String) -> [String] {
		return input
			.split(separator: " ")
			.filter {
				!$0.isEmpty
			}
			.map {
				$0.lowercased()
			}
	}
}
