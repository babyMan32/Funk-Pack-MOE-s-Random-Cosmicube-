var redFuckFace:Character;
var redBitchyElement:FlxSpriteElement;

function onCreatePost()
{
	redFuckFace = new Character(0, -300, 'doubleTroubleRed');
	redFuckFace.danceEveryNumBeats = 2;
	redFuckFace.origin.set();

	redBitchyElement = new animate.internal.elements.FlxSpriteElement(redFuckFace);
	redBitchyElement.active = false;

	if (dad.library != null)
	{
		var bodyParts = [dad.library.getSymbol('parasite head'), dad.library.getSymbol('parasite down head'), dad.library.getSymbol('parasite up head')];

		if (bodyParts != null)
		{
			for (i in 0...bodyParts.length)
			{
				bodyParts[i].timeline.layers[0].forEachFrame((frame) -> {
					frame.add(redBitchyElement);
				});
			}
		}
	}
}

function onUpdate(elapsed:Float):Void
{
	redFuckFace.update(elapsed);
}

function onDestroy():Void
{
	redFuckFace.destroy();
}

function onBeatHit()
{
	redFuckFace.onBeatHit(curBeat);
}

function onCountdownTick()
{
	redFuckFace.onBeatHit(curBeat);
}

function opponentNoteHitPre(note)
{
	var greenSing:Bool = (note.noteType == 'Opponent 2 Sing');
	
	if (!greenSing)
	{
		note.owner = redFuckFace;
	}
	else
	{
		if (!note.isSustainNote && (!StringTools.startsWith(redFuckFace.animation.name, 'sing') || redFuckFace.holdTimer >= Conductor.stepCrotchet / 1500))
		{
			redFuckFace.playAnim(note.skin.singAnimations[note.noteData] + '-balance');
			redFuckFace.holdTimer = 0;
		}
	}
}