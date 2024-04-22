//

import Foundation

class PourCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		let tokens = tokens(from: input)

		guard tokens.count > 1 else {
			print(commandFeedback: "Pour what?", padding: .bottom)
			return
		}

		guard let sourceItem = ensure(tokens[1], in: player) else {
			return
		}

		guard sourceItem.definition.flags.contains(.vessel),
			  let sourceContents = sourceItem.inventory?.items.first else {
			print(commandFeedback: "There's nothing to pour out of \(sourceItem.definition.name)", padding: .bottom)
			return
		}

		guard sourceItem.inventory?.removeAll() ?? 0 > 0 else {
			log(.warn, "Failed to pour \(sourceItem)")
			return
		}

		print(commandFeedback: "You've poured all \(sourceContents.definition.name) out of \(sourceItem.definition.name) on the ground.", padding: .bottom)
	}
}
