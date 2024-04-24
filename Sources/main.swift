import TOMLKit
import Foundation

let splash = #"""
$*    _       _                   _
   ('<     ('<                 >')
   (^)     (^)                 (^)
   |m/|   |\m|   |\/|   |\/|   |m/|   |\/|
   |  | _ |  | _ |  | _ |  | _ |  | _ |  |
   |  |(@)|  |<.>|  |{o}|  |<.>|  |(@)|  |
 __|__|_|_|__|_|_|__|_|_|__|_|_|__|_|_|__|__
|___::__$GF$*__::__$G@$*__::__$GR$*__::__$GM$*__::__$G?$*__::___|
   |  | | |  | | |  | | |  | | |  | | |  |
   |  |\|/|  |\|/|  |\|/|  |\|/|  |\|/|  |ldb
$gW$GW$gWWWWWWWWW$GW$gWW$GW$gWWWWWWWW$GW$gWW$GW$gWWWWWWWWW$GW$gWWWWWWWW$*
"""#

colorPrint(splash)

let player = Player()
let world = World(player: player)
let roomRender = RoomRender()

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

Loader<AreaDefinition>()
	.load(from: "Resources/Areas")
	.forEach {
		world.load(area: $0)
	}



player.currentRoom = world.areas[1]?.defaultRoom ?? .invalid
roomRender.render(room: world.rooms[player.currentRoom], limitItems: true)
player.money += 500
world.dayPass()


let prompt = PromptRender()
while true {
	prompt.render(for: player, in: world)
	guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else {
		continue
	}
	let command = CommandRegistry.shared.command(for: input)
	command.execute(input: input, in: world, by: player)
}

