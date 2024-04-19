//

import Foundation

struct ItemDefinitions: Codable {
	let items: [ItemDefinition]
}

struct ItemDefinition: Codable {
	let id: Int
	let name: String
}
