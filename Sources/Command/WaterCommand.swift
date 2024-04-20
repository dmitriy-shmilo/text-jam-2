//

import Foundation

class WaterCommand: Command {
	private static let transformationAction = "water"

	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Water what and with what?", padding: .bottom)
			return
		}

		let targetToken = tokens[1]
		guard let targetItem = currentRoom.inventory.find(term: targetToken.term, order: targetToken.order) else {
			print(commandFeedback: "There's no '\(targetToken.term)' here.", padding: .bottom)
			return
		}

		guard tokens.count > 2 else {
			print(
				commandFeedback: "Water \(targetItem.definition.name) with what?",
				padding: .bottom)
			return
		}

		let sourceToken = tokens[2]
		guard let sourceItem = player.inventory.find(term: sourceToken.term, order: sourceToken.order) else {
			print(
				commandFeedback: "You don't have '\(sourceToken.term)'.",
				padding: .bottom)
			return
		}

		guard sourceItem.definition.flags.contains(.vessel),
			  let sourceInventory = sourceItem.inventory,
			  let sourceContents = sourceInventory.items.first,
			  sourceContents.quantity > 0 else {
			print(commandFeedback: "There's nothing in \(sourceItem.definition.name) to water with.")
			return
		}

		let requiredQuantity = 2 // TODO: skill

		guard sourceContents.quantity > requiredQuantity else {
			print(commandFeedback: "Threre's not enough \(sourceContents.definition.name) in \(sourceItem.definition.name)", padding: .bottom)
			return
		}

		guard let transformation = targetItem.definition.transformations.first(where: { $0.action == Self.transformationAction }),
			  let targetItemDef = itemDatabase[transformation.targetId] else {
			print(commandFeedback: "You can't water \(targetItem.definition.name).")
			return
		}

		_ = sourceInventory.remove(item: sourceContents, quantity: requiredQuantity)
		currentRoom.inventory.transform(item: targetItem, into: targetItemDef, count: 1)
		print(commandFeedback: "You water \(targetItem.definition.name).", padding: .bottom)

	}
}
