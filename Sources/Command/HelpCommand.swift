//

import Foundation

class HelpCommand: Command {
	let articles: [HelpArticle]
	let render = HelpArticleRender()

	init(name: String, articles: [HelpArticle]) {
		self.articles = articles
		super.init(name: name)
	}

	override func execute(input: String, in world: World, by player: Player) {
		let tokens = tokens(from: input)
		let term = tokens.count > 1 ? tokens[1].term : ""
		guard let article = articles
			.first(where: {
				$0.terms.contains(where: { $0 == term })
			}) ?? articles
			.first(where: {
				$0.terms.contains(where: { $0.hasPrefix(term) })
			}) else {
			colorPrint("There's no help article about '$y\(term)$*'.")
			return
		}

		render.render(article: article)
	}
}
