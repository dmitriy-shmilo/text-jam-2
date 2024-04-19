//

import Foundation

struct RoomRender {
	func render(room: Room) {
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
	}
}

extension RoomRender {
	func render(room: Room?) {
		guard let room = room else {
			return
		}
		render(room: room)
	}
}
