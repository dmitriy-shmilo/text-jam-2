//

import Foundation

struct HelpArticles: Codable {
	let articles: [HelpArticle]
}

struct HelpArticle: Codable {
	let name: String
	let terms: [String]
	let description: String
	let references: [String]
}
