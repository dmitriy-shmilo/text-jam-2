//

import Foundation

enum ANSIColors: String {
	case black = "\u{001B}[0;90m"
	case red = "\u{001B}[0;91m"
	case green = "\u{001B}[0;92m"
	case yellow = "\u{001B}[0;93m"
	case blue = "\u{001B}[0;94m"
	case magenta = "\u{001B}[0;95m"
	case cyan = "\u{001B}[0;96m"
	case white = "\u{001B}[0;97m"
	case `default` = "\u{001B}[0;0m"

	case darkBlack = "\u{001B}[0;30m"
	case darkRed = "\u{001B}[0;31m"
	case darkGreen = "\u{001B}[0;32m"
	case darkYellow = "\u{001B}[0;33m"
	case darkBlue = "\u{001B}[0;34m"
	case darkMagenta = "\u{001B}[0;35m"
	case darkCyan = "\u{001B}[0;36m"
	case darkWhite = "\u{001B}[0;37m"
}

extension ANSIColors {
	private static let tokenMap = [
		"$" : "$",
		"*" : ANSIColors.default.rawValue,
		"d" : ANSIColors.darkBlack.rawValue,
		"r" : ANSIColors.darkRed.rawValue,
		"g" : ANSIColors.darkGreen.rawValue,
		"y" : ANSIColors.darkYellow.rawValue,
		"b" : ANSIColors.darkBlue.rawValue,
		"m" : ANSIColors.darkMagenta.rawValue,
		"c" : ANSIColors.darkCyan.rawValue,
		"w" : ANSIColors.darkWhite.rawValue,
		"D" : ANSIColors.black.rawValue,
		"R" : ANSIColors.red.rawValue,
		"G" : ANSIColors.green.rawValue,
		"Y" : ANSIColors.yellow.rawValue,
		"B" : ANSIColors.blue.rawValue,
		"M" : ANSIColors.magenta.rawValue,
		"C" : ANSIColors.cyan.rawValue,
		"W" : ANSIColors.white.rawValue,
	]

	static func replacingColorTokens(in string: String) -> String {
		guard string.contains("$") else {
			return string
		}

		var result = ""
		var isEscaping = false
		for char in string {
			if char == "$" && !isEscaping {
				isEscaping = true
				continue
			}

			if isEscaping {
				result += Self.tokenMap[String(char)] ?? ""
				isEscaping = false
				continue
			}
			result += String(char)
		}

		return result
	}

	static func removingColorTokens(in string: String) -> String {
		guard string.contains("$") else {
			return string
		}

		var result = ""
		var isEscaping = false
		for char in string {
			if char == "$" && !isEscaping {
				isEscaping = true
				continue
			}

			if isEscaping {
				isEscaping = false
				continue
			}

			result += String(char)
		}

		return result
	}
}

enum PrintPadding {
	case none
	case top
	case bottom
	case both
}

func colorPrint(_ string: String, breakLine: Bool = true) {
	print(ANSIColors.replacingColorTokens(in: string) + ANSIColors.default.rawValue, terminator: breakLine ? "\n" : "")
}

func colorPrint(_ string: String, filling color: ANSIColors) {
	print(color.rawValue + ANSIColors.removingColorTokens(in: string) + ANSIColors.default.rawValue)
}

func print(commandFeedback: String, padding: PrintPadding = .none) {
	switch padding {
	case .both, .top:
		print()
	default:
		break
	}
	print(ANSIColors.darkWhite.rawValue + ANSIColors.replacingColorTokens(in: commandFeedback) + ANSIColors.default.rawValue)
	switch padding {
	case .both, .bottom:
		print()
	default:
		break
	}
}
