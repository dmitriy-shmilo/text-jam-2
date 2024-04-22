//

import Foundation

extension String {
	func paddingLeft(toLength: Int, withPad: String = " ") -> String {
		return "".padding(
			toLength: toLength - self.count,
			withPad: withPad,
			startingAt: 0) + self
	}

	func paddingRight(toLength: Int, withPad: String = " ") -> String {
		return self.padding(
			toLength: toLength,
			withPad: withPad,
			startingAt: 0)
	}
}
