import flixel.FlxObject;

using StringTools;

var doWeLegs:Bool = false;
public var bfOldLegs:Character;
var bfAnchorPoint:Array<Float> = [0, 0];
var legPosY = [13, 7, -3, -1, -1, 2, 7, 9, 7, 2, 0, 0, 3, 1, 3, 7, 13];

var startedFakeout = false;

var getTrolled = false;

function onLoad()
{
	doWeLegs = (ClientPrefs.bfSkin == 'boyfriend' && PlayState.SONG.stage == 'danger');

	getTrolled = FlxG.random.bool((1 / 4096) * 100);

	if (!doWeLegs) return;

	bfOldLegs = new Character(0, 0, 'boyfriend-legs', true);
	boyfriendGroup.insert(0, bfOldLegs);
}

function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "maroon":
			changeCharacter("boyfriend-christmas", 0);

		case "o2", "jads", "chef":
			changeCharacter("boyfriend-with-girlfriend", 0);

		case "boiling":
			changeCharacter("boyfriend-christmas", 0);

			if (ClientPrefs.shaders)
			{
				var blackRimlightBase:ExtraDropShadowShader = new funkin.game.shaders.ExtraDropShadowShader();
	
				blackRimlightBase.setColorMatrix([
					0.8,   0,   0, 0, 16,
					-.1, 0.6, -.1, 0,  0,
					  0,   0, 0.6, 0,  8,
					  0,   0,   0, 1,  0
			]);
			blackRimlightBase.addLayer([
					1.5, -.1, .2, 0, 64,
					-.3, 1.2,  0, 0, 32,
					  0,   0,  1, 0,  0,
					  0,   0,  0, 1,  0
				], 330, 25, .01);

				bfRim = blackRimlightBase;
				bfRim.attachedSprite = boyfriend;
			}
	}

	if (!doWeLegs) return;

	changeCharacter('boyfriend-running', 0);

	bfOldLegs.x = game.boyfriend.x + 10;
	bfOldLegs.y = game.boyfriend.y + 205;
	bfAnchorPoint[0] = game.boyfriend.x;
	bfAnchorPoint[1] = game.boyfriend.y;
}

function onUpdatePost(elapsed)
{
	if (!doWeLegs) return;

	game.boyfriend.y = bfAnchorPoint[1] + legPosY[bfOldLegs.animation.curAnim.curFrame];

	// This changes the legs from the miss version to the normal one and makes sure it starts on the same animation frame where it left off
	if (!boyfriend.getAnimName().contains('miss') && bfOldLegs.getAnimName().contains('miss'))
	{
		var lastFrame:Int = 0;
		lastFrame = bfOldLegs.animation.curAnim.curFrame;
		bfOldLegs.idleSuffix = '';
		bfOldLegs.recalculateDanceIdle();
		bfOldLegs.animation.curAnim.curFrame = lastFrame;
	}

	if (boyfriend.getAnimName().contains('dance'))
	{
		bfOldLegs.visible = false;
	}
}

function goodNoteHit()
{
	if (!doWeLegs) return;

	bfOldLegs.visible = true;
}

function onKeyRelease()
{
	if (!doWeLegs) return;

	game.boyfriend.danced = bfOldLegs.danced;
}

function onCountdownTick()
{
	if (!doWeLegs) return;

	bfOldLegs.dance();
}

function onBeatHit()
{
	if (!doWeLegs) return;

	if (curBeat % 1 == 0)
	{
		bfOldLegs.dance();
	}
}

// This changes the legs from the normal version to the miss version and makes sure it starts on the same animation frame where it left off
function noteMiss(daNote)
{
	if (!doWeLegs) return;

	var lastFrame:Int = 0;
	
	lastFrame = bfOldLegs.animation.curAnim.curFrame;
	bfOldLegs.idleSuffix = '-miss';
	bfOldLegs.recalculateDanceIdle();
	bfOldLegs.animation.curAnim.curFrame = lastFrame;
}

function goodNoteHit(note)
{
	final strumPlay:StrumNote = note.strum;

	if (strumPlay == null) return;

	if (!cpuControlled)
	{
		strumPlay.animation.onFinish.add((animName) -> {
			if (animName == 'confirm')
			{
				strumPlay.animation.play('pressed', true);
			}
		});
	}
}

function onPause()
{
	if (getTrolled && startedFakeout)
	{
		return Function_Stop;
	}
}

function onGameOver()
{
	if (getTrolled)
	{
		KillNotes();
		PlayState.instance.audio?.stop();
		camHUD.alpha = 0;

		camFollow = new FlxObject(boyfriend.getMidpoint().x - boyfriend.cameraPosition[0] - 100, boyfriend.getMidpoint().y + boyfriend.cameraPosition[1] - 100);
		FlxG.camera.follow(camFollow, true, 0);

		if (!startedFakeout)
		{
			fuckassVOID = new FlxSprite(0, 0).makeGraphic(5000, 5000, 0xff000000);
			fuckassVOID.screenCenter();
			add(fuckassVOID);

			boyfriend_troll = new Character(0, 0, 'boyfriend_fakeout', true);
			add(boyfriend_troll);
			boyfriend_troll.x = boyfriend.x;
			boyfriend_troll.y = boyfriend.y;
			boyfriend_troll.playAnim('trolololololol');

			FlxG.sound.play(Paths.sound('rareChance/fakeout_death', null, PathsTestMode.LOOSE));

			new FlxTimer().start(6.25, function(_) getTrolled = false);
		}

		startedFakeout = true;

		return Function_Stop;
	}
}