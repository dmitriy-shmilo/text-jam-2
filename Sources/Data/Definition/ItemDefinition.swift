//

import Foundation

struct ItemFlags: OptionSet, Codable {
	let rawValue: UInt16

	static let none = ItemFlags([])
	static let noPickup = ItemFlags(rawValue: 1)
	static let noList = ItemFlags(rawValue: 1 << 1)
}

struct ItemDefinitions: Codable {
	let items: [ItemDefinition]
}

struct ItemDefinition: Codable {
	let id: Int
	let name: String
	private(set) var tags: [String]
	private(set) var flags: ItemFlags

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		if container.contains(.tags) {
			self.tags = try container.decode([String].self, forKey: .tags)
		} else {
			self.tags = []
		}
		if container.contains(.flags) {
			let flags = try container.decode([String].self, forKey: .flags)
				.compactMap {
					switch $0 {
					case "nopickup":
						return ItemFlags.noPickup
					case "nolist":
						return ItemFlags.noList
					default:
						return nil
					}
				}
				.reduce(into: 0, { (res: inout UInt16, flag: ItemFlags) in
					res |= flag.rawValue
				})
			self.flags = ItemFlags(rawValue: flags)
		} else {
			self.flags = .none
		}
	}
}
