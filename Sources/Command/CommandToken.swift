//

import Foundation

struct CommandToken {
	var term: String
	var quantity: Int
	var order: Int
}

extension [CommandToken] {
	subscript(checked index: Int) -> CommandToken? {
		guard index >= 0 && index < count else {
			return nil
		}
		return self[index]
	}
}
