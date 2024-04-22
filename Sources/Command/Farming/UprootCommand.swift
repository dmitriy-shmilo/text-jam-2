//

import Foundation

class UprootCommand: Command {
	private static let transformationAction = "uproot"

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard let targetToken = tokens[checked: 1] else {
			print(commandFeedback: "Uproot what?", padding: .bottom)
			return
		}

		guard let targetItem = currentRoom
			.inventory
			.find(
				term: targetToken.term,
				order: targetToken.order) ?? currentRoom
			.inventory
			.items
			.dropFirst(targetToken.order)
			.first(where: {
				!($0.inventory?.find(term: targetToken.term) ?? []).isEmpty
			}) else {
			print(commandFeedback: "There's no '\(targetToken.term)' here.", padding: .bottom)
			return
		}

		guard let targetInventory = targetItem.inventory,
			  let transformatbleItem = targetInventory.items.first(where: {
				  $0.can(transform: Self.transformationAction, inside: targetItem)
			  }),
			  let transform = transformatbleItem.definition.transformations[Self.transformationAction],
			  let targetDef = itemDatabase[transform.targetId]
		else {
			print(
				commandFeedback: "There's nothing to uproot in \(targetItem.definition.name).",
				padding: .bottom)
			return
		}

		if transformatbleItem.progress(transform: transform, by: transform.step) {
			targetInventory.transform(
				item: transformatbleItem,
				into: targetDef,
				in: world,
				movingTo: player.inventory)
			print(commandFeedback: "You uprooted \(transformatbleItem.definition.name) and got \(targetDef.name).")
			return
		}

		print(commandFeedback: "You're uprooting \(transformatbleItem.definition.name). Keep going.")
	}
}
