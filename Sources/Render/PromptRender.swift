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
		colorPrint("$c<$W\(world.currentTime.timeString())$c, $W\(player.money)$yc$c, $W\(energy)$me$c>", breakLine: false)
	}
}
