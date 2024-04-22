//

import Foundation

class FillCommand: Command {
	override func execute(input: String, in world: World, by player: Player) {
		guard let currentRoom = world.rooms[player.currentRoom] else {
			return
		}

		let tokens = tokens(from: input)
		guard tokens.count > 1 else {
			print(commandFeedback: "Fill what?", padding: .bottom)
			return
		}

		guard tokens.count > 2 else {
			print(commandFeedback: "Fill from where?", padding: .bottom)
			return
		}

		guard let targetItem = ensure(tokens[1], in: player) else {
			return
		}

		guard let sourceItem = ensure(tokens[2], in: currentRoom) else {
			return
		}

		guard targetItem.definition.flags.contains(.vessel) else {
			print(commandFeedback: "You can't fill \(targetItem.definition.name) with liquid.")
			return
		}

		guard let sourceInventory = sourceItem.inventory,
			  let sourceContents = sourceInventory.items.first,
			  sourceItem.definition.flags.contains(.source),
			  sourceContents.definition.flags.contains(.liquid)
			else {
			print(commandFeedback: "You can't fill \(targetItem.definition.name) from \(sourceItem.definition.name).", padding: .bottom)
			return
		}

		guard let targetInventory = targetItem.inventory,
			  targetInventory.items.first == nil
				|| targetInventory.items.first?.definition.id == sourceContents.definition.id else {
			print(commandFeedback: "You can't mix different liquids", padding: .bottom)
			return
		}

		if let targetContents = targetInventory.items.first {
			targetContents.quantity = targetItem.definition.capacity
		} else {
			let targetContents = sourceContents.copy(in: world)
			targetContents.quantity = targetItem.definition.capacity
			_ = targetInventory.add(item: targetContents)
		}
		print(commandFeedback: "You fill \(targetItem.definition.name) with \(sourceContents.definition.name).", padding: .bottom)
	}
}
