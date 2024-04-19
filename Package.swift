// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let resources = [Resource.copy("Resources/")]

let package = Package(
	name: "text-jam-2",
	platforms: [
		.macOS(.v10_15),
	],
	dependencies: [
		.package(url: "https://github.com/LebJe/TOMLKit", from: "0.6.0")
	],
	targets: [
		.executableTarget(
			name: "text-jam-2",
			dependencies: ["TOMLKit"],
			path: "Sources",
			resources: resources),
	]
)
