//

import Foundation

struct ItemTransformation {
	let action: String
	let targetId: Int
	let containerId: Int?
	let step: Float
	let contents: [Int]?
}

extension [ItemTransformation] {
	subscript(_ action: String) -> ItemTransformation? {
		get {
			return first(where: { $0.action == action })
		}
	}
}

// MARK: - Codable
extension ItemTransformation: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		action = try container.decode(String.self, forKey: .action)
		targetId = try container.decode(Int.self, forKey: .targetId)
		containerId = try container.decodeIfPresent(Int.self, forKey: .containerId)
		step = try container.decodeIfPresent(Float.self, forKey: .step) ?? 1.0
		contents = try container.decodeIfPresent([Int].self, forKey: .contents)
	}
}

// MARK: - Hashable
extension ItemTransformation: Hashable {
}

