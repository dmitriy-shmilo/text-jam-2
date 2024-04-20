//

import Foundation

struct HelpArticleRender {
	func render(article: HelpArticle) {
		print()
		colorPrint("$CHelp:$W \(article.name)", filling: .cyan)

		if let format = article.format {
			colorPrint("Format:", filling: .cyan)
			colorPrint(format, filling: .yellow)
			print()
		}

		if let example = article.example {
			colorPrint("Examples:", filling: .cyan)
			colorPrint(example, filling: .yellow)
			print()
		}

		if article.format != nil || article.example != nil {
			colorPrint("Details:", filling: .cyan)
		}
		colorPrint(article.description)

		if !article.references.isEmpty {
			print()
			colorPrint("See also: $C\(article.references.joined(separator: ", "))$*.")
		}
		print()
	}
}
