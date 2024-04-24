//

import Foundation
import TOMLKit

class SaveManager {
	private static let saveFolder = ".text-jam-2"
	private static let saveFile = ".text-jam-2/save.toml"
	
	func hasSaveFile() -> Bool {
		let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
			.appendingPathComponent(Self.saveFile)
		return FileManager.default.fileExists(atPath: url.path)
	}

	func save(world: World) {
		log(.info, "save world")
		// TODO: error handling
		let folderUrl = URL(
			fileURLWithPath: FileManager.default.currentDirectoryPath)
			.appendingPathComponent(Self.saveFolder)
		let saveUrl = URL(
			fileURLWithPath: FileManager.default.currentDirectoryPath)
			.appendingPathComponent(Self.saveFile)
		do {
			try FileManager.default.createDirectory(
				at: folderUrl,
				withIntermediateDirectories: true)
			guard let save = try? TOMLEncoder()
				.encode(world)
				.data(using: .utf8) else {
				log(.error, "Can't encode save data.")
				return
			}
			try save.write(to: saveUrl)
		} catch {
			log(.error, "Can't save to \(saveUrl). Error: \(error.localizedDescription)")
		}
	}

	func load() -> World? {
		let saveUrl = URL(
			fileURLWithPath: FileManager.default.currentDirectoryPath)
			.appendingPathComponent(Self.saveFile)
		guard let toml = try? String(contentsOf: saveUrl) else {
			return nil
		}
		return try? TOMLDecoder().decode(World.self, from: toml)
	}
}
