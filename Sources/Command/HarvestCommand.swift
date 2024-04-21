//

import Foundation

class HarvestCommand: Command {
	private static let transformationAction = "harvest"

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Harvest what?", padding: .bottom)
			return
		}

		let targetToken = tokens[1]
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
			  let harvestableItem = targetInventory.items.first(where: {
				  $0.can(transform: Self.transformationAction, inside: targetItem)
			  }),
			  let transform = harvestableItem.definition.transformations[Self.transformationAction],
			  let targetDef = itemDatabase[transform.targetId]
		else {
			print(
				commandFeedback: "There's nothing to harvest in \(targetItem.definition.name).",
				padding: .bottom)
			return
		}

		if harvestableItem.progress(transform: transform, by: transform.step) {
			// TODO: spawn multiple items
			targetInventory.transform(
				item: harvestableItem,
				into: targetDef,
				in: world,
				movingTo: player.inventory)
			print(commandFeedback: "You harvested \(harvestableItem.definition.name) and got \(targetDef.name).")
			return
		}

		print(commandFeedback: "You're harvesting \(harvestableItem.definition.name). Keep going.")
	}
}
