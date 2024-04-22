//

import Foundation

extension String {
	func paddingLeft(toLenth: Int, withPad: String = " ") -> String {
		return "".padding(
			toLength: toLenth - self.count,
			withPad: withPad,
			startingAt: 0) + self
	}

	func paddingRight(toLenth: Int, withPad: String = " ") -> String {
		return self.padding(
			toLength: toLenth,
			withPad: withPad,
			startingAt: 0)
	}
}
