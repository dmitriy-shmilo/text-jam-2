//

import Foundation

struct PlacedItem {
	let id: Int
	let containerId: Int?
	let containerOrder: Int?
	let count: Int?
}

// MARK: - Codable
extension PlacedItem: Codable {

}
