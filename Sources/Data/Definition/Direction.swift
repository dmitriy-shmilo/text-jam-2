//

import Foundation

enum Direction: Int {
	case north = 0
	case east = 1
	case south = 2
	case west = 3
}

extension Direction {
	var localizedName: String {
		switch self {
		case .north:
			return NSLocalizedString("north", comment: "")
		case .east:
			return NSLocalizedString("east", comment: "")
		case .south:
			return NSLocalizedString("south", comment: "")
		case .west:
			return NSLocalizedString("west", comment: "")
		}
	}
}
