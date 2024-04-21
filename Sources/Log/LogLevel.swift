//

import Foundation

enum LogLevel {
	case debug
	case info
	case warn
	case error
}

extension LogLevel {
	var label: String {
		switch self {
		case .debug:
			return "[DEBUG]"
		case .info:
			return "[INFO]"
		case .warn:
			return "[WARN]"
		case .error:
			return "[ERROR]"
		}
	}

	var labelColor: ANSIColors {
		switch self {
		case .debug:
			return .darkGreen
		case .info:
			return .darkCyan
		case .warn:
			return .yellow
		case .error:
			return .red
		}
	}

	var messageColor: ANSIColors {
		switch self {
		case .debug:
			return .black
		case .info:
			return .black
		case .warn:
			return .darkWhite
		case .error:
			return .white
		}
	}
}
