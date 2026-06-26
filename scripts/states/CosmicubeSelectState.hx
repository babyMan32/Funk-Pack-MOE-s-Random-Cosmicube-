import funkin.data.CharacterData.CharacterParser; //huge shoutout to kludge for making this

var checked:Bool = false;

function onUpdate()
{
	if (!checked) // check if we are in a substate
	{
		if (FlxG.state.subState != null)
		{
			checked = true;
			FlxG.state.subState.closeCallback = function() { checked = false; } // check for the next substate after we exit this one

			if (FlxG.state.subState.cosmicube == 'morefucks')
			{
				FlxG.signals.postUpdate.addOnce(patchStuff); // on the extra characters substate! run patch
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
			var icon = new FlxSprite().loadGraphic(Paths.image('icons/icon-' + charInfo.healthicon), true, 150);
			icon.active = false;
			icon.setGraphicSize(135);
			icon.updateHitbox();
			icon.x -= 150;
			icon.y -= 150;
			node.add(icon);
		}
	}

	for (i in node.attachedNodes) // check all attached nodes also
	{
		if (i == null) continue;

		handleNode(i);
	}
}