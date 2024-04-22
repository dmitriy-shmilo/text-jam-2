//

import Foundation

struct HelpArticleRender {
	func render(article: HelpArticle) {
		print()
		colorPrint("$CHelp:$W \(article.name)", filling: .cyan)

		if let format = article.format {
			colorPrint("Format:", filling: .cyan)
			colorPrint(format, filling: .darkWhite)
			print()
		}

		if let example = article.example {
			colorPrint("Examples:", filling: .cyan)
			colorPrint(example, filling: .darkWhite)
			print()
		}

		if article.format != nil || article.example != nil {
			colorPrint("Details:", filling: .cyan)
		}
		colorPrint(article.description)

		if !article.references.isEmpty {
			print()
			colorPrint("See also: $G\(article.references.joined(separator: ", "))$*.")
		}
		print()
	}
}
