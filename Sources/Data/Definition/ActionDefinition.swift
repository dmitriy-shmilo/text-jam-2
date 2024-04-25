//

import Foundation

struct ActionDefinition: Codable {
	let name: String
	let energyMultiplier: Double?
	let timeMultiplier: Double?
}

extension ActionDefinition {
	var energyMultiplierOrDefault: Double {
		return energyMultiplier ?? 1.0
	}

	var timeMultiplierOrDefault: Double {
		return timeMultiplier ?? 1.0
	}
}

extension [ActionDefinition] {
	subscript(_ name: String) -> ActionDefinition? {
		return first(where: { $0.name == name })
	}
}
