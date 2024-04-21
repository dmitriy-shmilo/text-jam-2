//

import Foundation

extension Float {
	static let tolerance: Float = 0.0001

	func isEqualWithinTolerance(to other: Float) -> Bool {
		return abs(self - other) <= Self.tolerance
	}

	func isGreaterThanOrEqualWithinTolerance(to other: Float) -> Bool {
		return self > other || abs(self - other) <= Self.tolerance
	}
}
