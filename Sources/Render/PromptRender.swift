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
		colorPrint("$c<$W\(world.currentTime.timeString())$c, $W\(player.money)$Yc$c, \(energyColor)\(energy)$c>", breakLine: false)
	}

	private func energyColor(_ energy: Float) -> ANSIColors {
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
