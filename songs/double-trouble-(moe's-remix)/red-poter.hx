var redFuckFace:Character;
var redBitchyElement:FlxSpriteElement;

var greenSing:Bool = false;

var stroed1 = 0;
var sotred2 = 0;

function onCreatePost()
{
	redFuckFace = new Character(-100, -300, 'doubleTroubleRed');
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

	camSpecialThing([-250, 750], [1250, 875]);

	dad.singDuration = 8;
	boyfriend.singDuration = 8;
	redFuckFace.singDuration = 8;

	stroed1 = bfOff[0];
	sotred2 = bfOff[1];
}

function onUpdate(elapsed:Float):Void
{
	redFuckFace.update(elapsed);

	if (boyfriend.getFlag('floating') == true)
	{
		songPos = Conductor.songPosition;

		currentBeat = (songPos / 5000) * (Conductor.bpm / 60);
		currentBeatSlow = (songPos / 5000) * (Conductor.bpm / 105);

		boyfriend.offset.x = 150 * Math.sin((currentBeatSlow + 12 * 12) * Math.PI);
		boyfriend.offset.y = -300 + 150 * Math.sin((currentBeat + 12 * 12) * Math.PI);

		bfOff[0] = stroed1 - boyfriend.offset.x;
		bfOff[1] = (sotred2 - boyfriend.offset.y) - 300;
	}
}

function onDestroy():Void
{
	if (dad.library != null)
	{
		var bodyParts = [dad.library.getSymbol('parasite head'), dad.library.getSymbol('parasite down head'), dad.library.getSymbol('parasite up head')];

		if (bodyParts != null)
		{
			for (i in 0...bodyParts.length)
			{
				bodyParts[i].timeline.layers[0].forEachFrame((frame) -> {
					frame.remove(redBitchyElement);
				});
			}
		}
	}
}

function onBeatHit()
{
	redFuckFace.onBeatHit(curBeat);
}

function onCountdownTick()
{
	redFuckFace.onBeatHit(curBeat);
}

function goodNoteHitPre(note)
{
	defaultCamZoom = 0.45;
}

function opponentNoteHitPre(note)
{
	greenSing = (note.noteType == 'Opponent 2 Sing');
	
	if (!greenSing)
	{
		dadOff[1] = 500;
		defaultCamZoom = 0.45;
		note.owner = redFuckFace;
		playHUD.iconP2.changeIcon('red');
		playHUD.scoreTxt.color = -4510419;
		playHUD.healthBar.setColors(-4510419, null);
	}
	else
	{
		FlxG.signals.postUpdate.addOnce(function() {
			if (!StringTools.startsWith(redFuckFace.animation.name, 'sing') || redFuckFace.holdTimer >= Conductor.stepCrotchet / 1500)
			{
				if (!note.isSustainNote)
				{
					redFuckFace.playAnim(note.skin.singAnimations[note.noteData] + '-balance');
					playHUD.healthBar.setColors(dad.healthColour, null);
					playHUD.iconP2.changeIcon(dad.healthIcon);
					playHUD.scoreTxt.color = dad.healthColour;
					redFuckFace.holdTimer = 0;
					defaultCamZoom = 0.45;
					dadOff[1] = 750;
				}
			}
			else
			{
				playHUD.healthBar.setColors(dad.healthColour, null);
				playHUD.iconP2.changeIcon('double-trouble');
				playHUD.scoreTxt.color = dad.healthColour;
				defaultCamZoom = 0.35;
				dadOff[1] = 750;
			}

			playHUD.iconP2.animation.curAnim.curFrame = (health >= 1.6 ? 1 : 0);
		});
	}
}