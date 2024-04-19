//

import Foundation

struct HelpArticleRender {
	func render(article: HelpArticle) {
		print()
		colorPrint("Help: \(article.name)", filling: .cyan)
		colorPrint(article.description)
		if !article.references.isEmpty {
			print()
			colorPrint("See also: $C\(article.references.joined(separator: ","))$*.")
		}
		print()
	}
}
