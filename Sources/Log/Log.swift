//

import Foundation

func log(_ level: LogLevel, _ message: String, context: String = "", stripColorMarkers: Bool = false) {
	guard level == .error || level == .warn else {
		return
	}
	#if DEBUG
	let message = stripColorMarkers
	? ANSIColors.removingColorTokens(in: message) : message

	if context.isEmpty {
		print("\(level.labelColor.rawValue)\(level.label)\(level.messageColor.rawValue) - \(message)")
	} else {
		print("\(level.labelColor.rawValue)\(level.label)\(level.messageColor.rawValue) - \(context) - \(message)")
	}
	#endif
}
