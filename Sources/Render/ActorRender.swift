//

import Foundation

struct ActorRender {
	let oneLine: Bool
	let prefix: String
	let suffix: String

	func render(actor: Actor) {
		if !oneLine {
			renderFullDescription(actor: actor)
			return
		}

		renderRoomLine(actor: actor)
	}

	// MARK: - Private Methods
	private func renderFullDescription(actor: Actor) {
		guard let description = actor.definition.description else {
			renderRoomLine(actor: actor)
			print()
			return
		}

		colorPrint("\(description)")
		print()
	}

	private func renderRoomLine(actor: Actor) {
		guard let description = actor.definition.roomDescription else {
			renderOneLine(actor: actor)
			return
		}
		colorPrint("\(prefix)\(description)")
	}

	private func renderOneLine(actor: Actor) {
		colorPrint("\(prefix)\(actor.definition.name)\(suffix)")
	}
}

extension ActorRender {
	static let roomLineRender = ActorRender(
		oneLine: true, prefix: "$Y", suffix: " $Yis here.")
	static let detailsRender = ActorRender(
		oneLine: false, prefix: "", suffix: "")
}
