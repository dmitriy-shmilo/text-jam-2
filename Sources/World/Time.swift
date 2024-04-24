//

import Foundation

struct DateTime {
	let secondsSinceMidnight: TimeInterval

	var minutes: Int {
		Int(secondsSinceMidnight / 60.0) % 60
	}

	var hours: Int {
		Int(secondsSinceMidnight / 3600.0)
	}
}

extension DateTime {
	init(hours: Int, minutes: Int) {
		self.init(secondsSinceMidnight: Double(hours * 3600) + Double(minutes * 60))
	}
	
	func timeString() -> String {
		return String(format: "%02d:%02d", hours, minutes)
	}

	static func +(lhs: DateTime, rhs: TimeInterval) -> DateTime {
		let time = lhs.secondsSinceMidnight + rhs
		let days = Int(time / 24.0 / 3600.0)
		if days > 0 {
			// TODO: track days
			log(.info, "\(days) days rollover")
		}
		return .init(secondsSinceMidnight: time)
	}

	static func +=(lhs: inout DateTime, rhs: TimeInterval) {
		lhs = lhs + rhs
	}
}
