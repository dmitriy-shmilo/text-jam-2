//

import Foundation

class Room {
	enum CodingKeys: String, CodingKey {
		case areaId, definition, inventory
	}

	// TODO: encode/decode actors
	let areaId: Int
	let definition: RoomDefinition
	let inventory: Inventory
	private (set) var actors = [Actor]()

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		areaId = try container.decode(Int.self, forKey: .areaId)
		definition = try container.decode(RoomDefinition.self, forKey: .definition)
		inventory = try container.decode(Inventory.self, forKey: .inventory)
		inventory.parent = self
	}

	init(areaId: Int, definition: RoomDefinition) {
		self.areaId = areaId
		self.definition = definition
		inventory = .init()
		inventory.parent = self
	}

	func add(actor: Actor) {
		guard !actors.contains(where: { $0 === actor }) else {
			log(.warn, "Prevented adding a duplicate actor to a room")
			return
		}
		actor.currentRoom = roomRef
		actors.append(actor)
	}

	func findActor(term: String, order: Int) -> Actor? {
		return actors
			.filter { actor in
				actor.matches(filter: term)
			}
			.dropFirst(order)
			.first
	}
}

extension Room {
	var roomRef: RoomRef {
		return .init(id: definition.id, areaId: areaId)
	}
}

// MARK: - ContainerEntity
extension Room: ContainerEntity {
	var debugDescription: String {
		return "\(definition.name)(\(definition.id))"
	}
}

// MARK: - Codable
extension Room: Codable {
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(areaId, forKey: .areaId)
		try container.encode(definition, forKey: .definition)
		try container.encode(inventory, forKey: .inventory)
	}
}
