//

import Foundation

struct Time {
	static let tickMinutes = 5

	let totalMinutes: Int

	var minutes: Int {
		totalMinutes % 60
	}

	var hours: Int {
		totalMinutes / 60
	}
}

extension Time {
	init(hours: Int, minutes: Int) {
		self.init(totalMinutes: hours * 60 + minutes)
	}
	
	func time(byAddingTicks ticks: Int) -> Time {
		return Time(totalMinutes: totalMinutes + ticks * Self.tickMinutes)
	}
	
	func timeString() -> String {
		return String(format: "%02d:%02d", hours, minutes)
	}
}
