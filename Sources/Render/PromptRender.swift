//

import Foundation

struct PromptRender {
	private static let percentFormatter = {
		let format = NumberFormatter()
		format.numberStyle = .percent
		format.maximumFractionDigits = 0
		return format
	}()

	func render(for player: Player, in world: World) {
		let energy = Self.percentFormatter.string(from: player.energy as NSNumber) ?? "0%"
		let energyColor = energyColor(player.energy).rawValue
		guard let room = world.rooms[player.currentRoom] else {
			return
		}
		colorPrint("$C<$W\(world.currentTime.timeString())$C, $W\(player.money)$Yc$C, \(energyColor)\(energy)$C, \(exits(in: room))$C>", breakLine: false)
	}

	// MARK: - Private Methods
	private func exits(in room: Room) -> String{
		var exitsLabel = "$c"
		if room.definition.exits[.north] != .invalid {
			exitsLabel += "n"
		}
		if room.definition.exits[.east] != .invalid {
			exitsLabel += "e"
		}
		if room.definition.exits[.south] != .invalid {
			exitsLabel += "s"
		}
		if room.definition.exits[.west] != .invalid {
			exitsLabel += "w"
		}
		return exitsLabel
	}

	private func energyColor(_ energy: Double) -> ANSIColors {
		switch player.energy {
		case 0.9...1.0:
			return .darkGreen
		case 0.7...0.9:
			return .green
		case 0.5...0.7:
			return .yellow
		case 0.25...0.5:
			return .magenta
		default:
			return .red
		}
	}
}
