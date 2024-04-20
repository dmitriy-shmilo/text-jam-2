//

import Foundation

struct ItemFlags: OptionSet {
	let rawValue: UInt16

	static let none = ItemFlags([])
	static let noPickup = ItemFlags(rawValue: 1)
	static let noList = ItemFlags(rawValue: 1 << 1)
	static let alwaysList = ItemFlags(rawValue: 1 << 2)
	static let container = ItemFlags(rawValue: 1 << 3)
	static let noStack = ItemFlags(rawValue: 1 << 4)
}

// MARK: - Codable
extension ItemFlags: Codable {
	init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		var result = ItemFlags.none

		while !container.isAtEnd {
			let string = try container.decode(String.self)
			switch string {
			case "nopickup":
				result.formUnion(.noPickup)
			case "nolist":
				result.formUnion(.noList)
			case "alwaysList":
				result.formUnion(.alwaysList)
			case "container":
				result.formUnion(.container)
			case "noStack":
				result.formUnion(.noStack)
			default:
				print("Unknown item flag: \(string)")
			}
		}

		rawValue = result.rawValue
	}
}
