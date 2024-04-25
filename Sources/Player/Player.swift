//

import Foundation

class Player: Entity {
	enum CodingKeys: String, CodingKey {
		case currentRoom, money, energy, inventory
	}

	var money = 0
	var energy: Double = 1.0
	let inventory: Inventory

	override init() {
		inventory = Inventory()
		super.init()
		inventory.parent = self
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		money = try container.decodeIfPresent(Int.self, forKey: .money) ?? 0
		energy = try container.decodeIfPresent(Double.self, forKey: .energy) ?? 0.0
		inventory = try container.decodeIfPresent(Inventory.self, forKey: .inventory) ?? .init()
		super.init()
		inventory.parent = self
		currentRoom = try container.decodeIfPresent(RoomRef.self, forKey: .currentRoom) ?? .invalid
	}
}

// MARK: - ContainerEntity
extension Player: ContainerEntity {
	var debugDescription: String {
		return "player"
	}
}

// MARK: - Codable
extension Player: Codable {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(money, forKey: .money)
		try container.encode(energy, forKey: .energy)
		try container.encode(inventory, forKey: .inventory)
		try container.encode(currentRoom, forKey: .currentRoom)
	}
}

