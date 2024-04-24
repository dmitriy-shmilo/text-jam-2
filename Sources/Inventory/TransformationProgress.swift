//

import Foundation

struct TransformationProgress: Codable {
	let progress: Float

	func progress(byAddingStep step: Float) -> TransformationProgress {
		return .init(progress: progress + step)
	}
}
