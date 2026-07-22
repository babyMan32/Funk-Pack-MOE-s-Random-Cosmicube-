import funkin.data.CharacterData.CharacterParser; //huge shoutout to kludge for making this
import flixel.graphics.frames.FlxTileFrames;

var checked:Bool = false;

var moesCubes = ['morefucks', 'extraplayer']; // to do: add 'extraextraplayer' in later cause it fucking breaks the game otherwise because no path is longer than one long-

function onUpdate()
{
	if (!checked) // check if we are in a substate
	{
		if (FlxG.state.subState != null)
		{
			checked = true;

			FlxG.state.subState.closeCallback = function() { checked = false; } // check for the next substate after we exit this one

			for (iconPatches in 0...moesCubes.length)
			{
				if (FlxG.state.subState.cosmicube == moesCubes[iconPatches])
				{
					FlxG.signals.postUpdate.addOnce(patchStuff); // on the extra characters substate! run patch
				}
			}
		}
	}
}

function patchStuff()
{
	var cosm = FlxG.state.subState; // substate

	for (i in 4...8)
		handleNode(cosm.maze.members[i]); // pass the first 4 nodes
}

// recursively patch each notes and its neighboring nodes
function handleNode(node)
{
	if (node.meta.type != 'pet') // if the character isnt a pet
	{
		var charInfo = CharacterParser.fetchInfo(node.meta.fileName); // get char info

		if (node.unlocked) // if its unlocked we add its icon
		{
			var icon = new FlxSprite().loadGraphic(Paths.image('icons/icon-' + charInfo.healthicon));
			icon.frames = FlxTileFrames.fromGraphic(icon.graphic, FlxPoint.get(icon.width / 2, icon.height)); // we split the icon in half depending on the width
			icon.active = false; node.add(icon);
			icon.setGraphicSize(140);
			icon.updateHitbox();
			icon.x -= 150;
			icon.y -= 150;
		}
	}

	for (i in node.attachedNodes) // check all attached nodes also
	{
		if (i == null) continue;

		handleNode(i);
	}
}