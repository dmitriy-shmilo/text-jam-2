//

import Foundation

struct IntroRender {
	func render() {
		let text = """
$*Hello, player, and thank you for checking out $RF$Y@$GR$BM$M?$*, a tiny
experimental farm sim. This game was intended to be reminiscent of old MUDs,
where a character moves around the world, and interacts with it using
textual commands.

Your goal is to take care of an old farm, $Gplant$* seeds, $Gharvest$* produce,
and $Gsell$* it to the townsfolk. Keep track of the $Wtime$* and $Genergy$*, both
displayed in your command prompt.

Make sure to $Glook$* around and definitely check out $Ghelp$* for more information.

How and why you got here, we don't know. But now here you are in your house,
on your farm, a few days after your arrival. You might want to look for some
tools and seeds lying around. And if you need something, there's a town to the
east, where you can $Gbuy$* additional supplies.

Have fun.

$D[Press Enter to Continue]$*
"""
		colorPrint(text)
	}
}
