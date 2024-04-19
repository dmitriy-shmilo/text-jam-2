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

Loader<AreaDefinition>()
	.load(from: "Resources/Areas")
	.forEach {
		world.load(area: $0)
	}

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

player.currentRoom = world.areas[1]?.defaultRoom ?? .invalid
roomRender.render(room: world.rooms[player.currentRoom], limitItems: true)
_ = player.inventory.add(item: .init(definition: items[0]))
var stack = Item(definition: items[1])
stack.quantity = 3
_ = player.inventory.add(item: stack)
player.money += 123

let homeRoom = world.rooms[.init(id: 1, areaId: 1)]
homeRoom?.inventory.add(item: .init(definition: items[2]))

let prompt = PromptRender()
while true {
	prompt.render(for: player, in: world)
	guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else {
		continue
	}
	let command = CommandRegistry.shared.command(for: input)
	command.execute(input: input, in: world, by: player)
}

