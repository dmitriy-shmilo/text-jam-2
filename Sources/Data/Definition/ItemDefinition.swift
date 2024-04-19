//

import Foundation

struct ItemFlags: OptionSet, Codable {
	let rawValue: UInt16

	static let none = ItemFlags([])
	static let noPickup = ItemFlags(rawValue: 1)
	static let noList = ItemFlags(rawValue: 1 << 1)
	static let alwaysList = ItemFlags(rawValue: 1 << 2)
}

struct ItemDefinitions: Codable {
	let items: [ItemDefinition]
}

struct ItemDefinition: Codable {
	let id: Int
	let name: String
	private(set) var roomDescription: String
	private(set) var description: String
	private(set) var tags: [String]
	private(set) var flags: ItemFlags

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.roomDescription = try container.decodeIfPresent(String.self, forKey: .roomDescription) ?? ""
		self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
		self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
		if container.contains(.flags) {
			let flags = try container.decode([String].self, forKey: .flags)
				.compactMap {
					switch $0 {
					case "nopickup":
						return .noPickup
					case "nolist":
						return .noList
					case "alwaysList":
						return .alwaysList
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
