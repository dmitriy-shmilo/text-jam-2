//

import Foundation

struct TransformationProgress {
	let progress: Float

	func progress(byAddingStep step: Float) -> TransformationProgress {
		return .init(progress: progress + step)
	}
}
