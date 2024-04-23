//

import Foundation

struct RoomRender {
	static let shortItemCount = 5

	func render(room: Room, limitItems: Bool) {
		colorPrint(room.definition.name, filling: .cyan)
		colorPrint(room.definition.description)
		print()

		renderExits(in: room)
		renderActors(in: room)
		renderItems(in: room, limitItems: limitItems)
	}

	// MARK: - Private Methods
	private func renderExits(in room: Room) {
		var exitsLabel = "Exits: ["
		if room.definition.exits[.north] != .invalid {
			exitsLabel += "n, "
		}
		if room.definition.exits[.east] != .invalid {
			exitsLabel += "e, "
		}
		if room.definition.exits[.south] != .invalid {
			exitsLabel += "s, "
		}
		if room.definition.exits[.west] != .invalid {
			exitsLabel += "w, "
		}
		exitsLabel.removeLast(2)
		exitsLabel += "]"
		colorPrint(exitsLabel, filling: .cyan)
		print()
	}

	private func renderItems(in room: Room, limitItems: Bool) {
		var hiddenCount = 0
		let visibleItems = room.inventory.visibleItems
		guard !visibleItems.isEmpty else {
			return
		}

		for i in 0..<visibleItems.count {
			let item = visibleItems[i]
			guard item.definition.flags.contains(.noHide)
					|| i < Self.shortItemCount
					|| !limitItems else {
				hiddenCount += 1
				continue
			}
			ItemRender.roomLineRender.render(item: item)
		}
		if hiddenCount > 0 {
			colorPrint(
				"and \(items.count - Self.shortItemCount) more...",
				filling: .black)
		}
		print()
	}

	private func renderActors(in room: Room) {
		guard !room.actors.isEmpty else {
			return
		}

		for actor in room.actors {
			ActorRender.roomLineRender.render(actor: actor)
		}
		print()
	}
}

extension RoomRender {
	func render(room: Room?, limitItems: Bool) {
		guard let room = room else {
			return
		}
		render(room: room, limitItems: limitItems)
	}
}
