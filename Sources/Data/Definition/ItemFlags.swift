//

import Foundation

struct ItemFlags: OptionSet {
	let rawValue: UInt16

	static let none = ItemFlags([])
	static let noPickup = ItemFlags(rawValue: 1)
	static let noList = ItemFlags(rawValue: 1 << 1)
	static let noHide = ItemFlags(rawValue: 1 << 2)
	static let container = ItemFlags(rawValue: 1 << 3)
	static let noStack = ItemFlags(rawValue: 1 << 4)
	static let noInteract = ItemFlags(rawValue: 1 << 5)
	static let vessel = ItemFlags(rawValue: 1 << 6)
	static let source = ItemFlags(rawValue: 1 << 7)
	static let liquid = ItemFlags(rawValue: 1 << 8)
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
			case "nohide":
				result.formUnion(.noHide)
			case "container":
				result.formUnion(.container)
			case "nostack":
				result.formUnion(.noStack)
			case "nointeract":
				result.formUnion(.noInteract)
			case "vessel":
				result.formUnion(.vessel)
			case "source":
				result.formUnion(.source)
			case "liquid":
				result.formUnion(.liquid)
			default:
				print("Unknown item flag: \(string)")
			}
		}

		rawValue = result.rawValue
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		let flags = ["noPickup", "noList", "noHide", "container", "noStack", "noInteract", "vessel", "source", "liquid"]

		for i in flags.enumerated() {
			if contains(ItemFlags(rawValue: 1 << i.offset)) {
				try container.encode(i.element)
			}
		}
	}
}
