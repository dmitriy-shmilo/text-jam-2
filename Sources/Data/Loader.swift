//

import Foundation
import TOMLKit

struct Loader<T> where T: Codable {
	func load(from subfolder: String) -> [T] {
		guard let urls = Bundle.module.urls(forResourcesWithExtension: "toml", subdirectory: subfolder) as [URL]? else {
			return []
		}

		return urls
			.compactMap { url in
				guard let toml = try? String(contentsOf: url) else {
					return nil
				}
				return try? TOMLDecoder().decode(T.self, from: toml)
			}
	}
}
