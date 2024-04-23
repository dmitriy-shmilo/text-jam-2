//

import Foundation

class World {
	private static let dayPassActions = ["overnight", "grow", "wilt"]
	var shouldQuit = false
	var areas = [Int: AreaDefinition]()
	var rooms = [RoomRef: Room]()
	var shops = [RoomRef: Shop]()
	var actors = [Int: Actor]()
	var currentTime = Time(hours: 7, minutes: 0)

	let player: Player

	private var lastId = 0
	private var timeBasedTranformers = [WeakRef<Item>]()

	init(player: Player) {
		self.player = player
	}

	func load(area: AreaDefinition) {
		log(.info, "load \(area)")
		areas[area.id] = area
		for roomDef in area.rooms {
			let room = Room(areaId: area.id, definition: roomDef)
			roomDef.placedItems
				.filter { $0.containerId == nil }
				.compactMap { itemDatabase[$0.id] }
				.forEach { item in
					_ = self.spawn(item: item, in: room.inventory, count: 1)
				}

			roomDef.placedItems
				.forEach { placedItem in
					guard let containerId = placedItem.containerId else {
						// placed on the first pass
						return
					}

					guard let itemDef = itemDatabase[placedItem.id] else {
						log(.error, "No item \(placedItem.id) in the database.")
						return
					}
					
					// TODO: support container order
					guard let container = room.inventory.items.first(where: { $0.definition.id == containerId }) else {
						log(.error, "No container \(containerId) in room \(room.definition.id)")
						return
					}

					guard let inventory = container.inventory else {
						log(.error, "Item \(container.definition.id) in room \(room.definition.id) doesn't have an inventory")
						return
					}

					_ = self.spawn(item: itemDef, in: inventory, count: placedItem.count)
				}

			roomDef.placedActors
				.forEach { actor in
					guard let actorDef = actorDatabase[actor.id] else {
						return
					}
					let actor = self.spawn(actor: actorDef, in: room)
					self.actors[actor.id] = actor
				}
			rooms[.init(id: roomDef.id, areaId: area.id)] = room
		}

		for shopDef in area.shops {
			let shop = Shop(definition: shopDef)
			shops[shopDef.room] = shop
			for placedItem in shopDef.items {
				guard let itemDef = itemDatabase[placedItem.id] else {
					log(.warn, "Can't add item (\(placedItem)) to the \(shop): no such item in the database.")
					continue
				}

				let item = spawn(item: itemDef, count: placedItem.count)
				_ = shop.inventory.add(item: item)
			}
		}
	}

	func unload(areaId: Int) {
		guard let area = areas[areaId] else {
			return
		}

		for room in area.rooms {
			rooms.removeValue(forKey: .init(id: room.id, areaId: area.id))
		}
	}

	// MARK: - Time Passing
	func dayPass() {
		log(.debug, "dayPass")
		purgeItems()
		// TODO: unload or refresh areas
		for item in timeBasedTranformers {
			guard let item = item.value,
				  let inventory = item.parent else {
				continue
			}

			if let transform = item.definition.transformations["grow"],
			   let targetDef = itemDatabase[transform.targetId] {
				if item.can(transform: transform, inside: inventory.parent as? Item) {
					if item.progress(transform: transform, by: transform.step) {
						inventory.transform(item: item, into: targetDef, in: self)
					}
				}
			}

			if let transform = item.definition.transformations["wilt"],
			   let targetDef = itemDatabase[transform.targetId] {
				if item.can(transform: transform, inside: inventory.parent as? Item) {
					if item.progress(transform: transform, by: transform.step) {
						inventory.transform(item: item, into: targetDef, in: self)
					}
				}
			}
		}

		for item in timeBasedTranformers {
			guard let item = item.value,
				  let inventory = item.parent else {
				continue
			}

			if let transform = item.definition.transformations["overnight"],
			   let targetDef = itemDatabase[transform.targetId] {
				if item.can(transform: transform, inside: inventory.parent as? Item) {
					if item.progress(transform: transform, by: transform.step) {
						inventory.transform(item: item, into: targetDef, in: self)
					}
				}
			}
		}
	}

	// MARK: - Entity Spawning
	func spawn(actor def: ActorDefinition, in room: Room) -> Actor {
		let actor = Actor(id: nextId(), definition: def)
		room.add(actor: actor)
		return actor
	}

	func spawn(item def: ItemDefinition, in inventory: Inventory, count: Int) -> Item {
		let item = Item(definition: def, quantity: count)
		item.parent = inventory
		if def.transformations.contains(where: { Self.dayPassActions.contains($0.action) }) {
			timeBasedTranformers.append(.init(item))
		}
		_ = inventory.add(item: item)
		log(.debug, "Spawned \(item)", stripColorMarkers: true)
		return item
	}

	func spawn(item def: ItemDefinition, count: Int) -> Item {
		let item = Item(definition: def, quantity: count)
		if def.transformations.contains(where: { Self.dayPassActions.contains($0.action) }) {
			timeBasedTranformers.append(.init(item))
		}
		log(.debug, "Spawned \(item)", stripColorMarkers: true)
		return item
	}

	// MARK: - Private Methods
	private func purgeItems() {
		log(.debug, "purgeItems")
		timeBasedTranformers = timeBasedTranformers
			.compactMap {
				guard let item = $0.value else {
					return nil
				}

				guard item.parent != nil else {
					log(.warn, "purging orphan item: \(item)")
					return nil
				}

				return $0
			}
	}

	private func nextId() -> Int {
		lastId += 1
		return lastId
	}
}
