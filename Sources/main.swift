import TOMLKit
import Foundation

SplashRender().render()
var player = Player()
var world = World(player: player)

let help = Loader<HelpArticles>()
	.load(from: "Resources/Help")
	.flatMap {
		$0.articles
	}

let items = Loader<ItemDefinitions>()
	.load(from: "Resources/Items")
	.flatMap {
		$0.items
	}

let actors = Loader<ActorDefinitions>()
	.load(from: "Resources/Actors")
	.flatMap {
		$0.actors
	}

let itemDatabase = items
	.reduce(into: [Int: ItemDefinition]()) { map, item in
		map[item.id] = item
	}

let actorDatabase  = actors
	.reduce(into: [Int: ActorDefinition]()) { map, actor in
		map[actor.id] = actor
	}

let areaDatabase = Loader<AreaDefinition>()
	.load(from: "Resources/Areas")
	.reduce(into: [Int: AreaDefinition]()) { map, area in
		map[area.id] = area
	}

let saveManager = SaveManager()
if let savedWorld = saveManager.load() {
	colorPrint("$DThe game loaded successfully")
	world = savedWorld
	player = savedWorld.player
} else {
	world.load(area: areaDatabase[1]!)
	world.load(area: areaDatabase[2]!)
	player.currentRoom = world.areas[1]?.defaultRoom ?? .invalid
	player.money += 500
	world.dayPass()

	IntroRender().render()
	_ = readLine()
}


LookCommand(name: "look").execute(input: "look", in: world, by: player)

let prompt = PromptRender()
while true {
	prompt.render(for: player, in: world)
	guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else {
		continue
	}
	let command = CommandRegistry.shared.command(for: input)
	command.execute(input: input, in: world, by: player)
}

