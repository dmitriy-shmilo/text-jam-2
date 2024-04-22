//

import Foundation

struct ScanRender {
	func render(currentRoom: Room, in world: World) {
		colorPrint("Here:", filling: .darkCyan)
		colorPrint(currentRoom.definition.name, filling: .default)
		print()

		if let exit = currentRoom.definition.exits.north,
		   let room = world.rooms[exit] {
			render(room: room, at: .north, in: world, marked: exit.areaId != currentRoom.areaId)
		}
		if let exit = currentRoom.definition.exits.east,
		   let room = world.rooms[exit] {
			render(room: room, at: .east, in: world, marked: exit.areaId != currentRoom.areaId)
		}
		if let exit = currentRoom.definition.exits.south,
		   let room = world.rooms[exit] {
			render(room: room, at: .south, in: world, marked: exit.areaId != currentRoom.areaId)
		}
		if let exit = currentRoom.definition.exits.west,
		   let room = world.rooms[exit] {
			render(room: room, at: .west, in: world, marked: exit.areaId != currentRoom.areaId)
		}
	}

	private func render(room: Room, at direction: Direction, in world: World, marked: Bool) {
		let areaName = world.areas[room.areaId]?.name ?? ""
		let areaMarker = marked ? "$D(\(areaName))" : ""
		colorPrint("\(direction.localizedName):", filling: .darkCyan)
		colorPrint("$*\(room.definition.name) \(areaMarker)")
		print()
	}
}
