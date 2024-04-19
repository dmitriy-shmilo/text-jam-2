//

import Foundation

struct RoomRender {
	static let shortItemCount = 5

	func render(room: Room, limitItems: Bool) {
		print()
		colorPrint(room.definition.name, filling: .cyan)
		colorPrint(room.definition.description)
		print()
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

		let items = room.inventory.visibleItems

		if items.count > Self.shortItemCount && limitItems {
			for item in items.prefix(upTo: Self.shortItemCount) {
				ItemRender.roomLineRender.render(item: item)
			}
			colorPrint("and \(items.count - Self.shortItemCount) more...", filling: .darkWhite)
			print()
			return
		}

		if !items.isEmpty {
			for item in items {
				ItemRender.roomLineRender.render(item: item)
			}
			print()
			return
		}
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
