import funkin.FunkinAssets;

var amongWalking = false;

var willBeKilled;

var flip = false;

var ext = 'stages/mira/cafeteria/';

var color = 'lime';
public var colours = ['blue', 'brown', 'lime', 'tan', 'white', 'yellow'];

var variance = 0;

var shouldWalk = true;

var baseY = 0;

var layer = dadGroup;

var fuckYouLegacy = ['Don\'t Lied', 'Armed'];

var regret = false;

var distanceAway = 0;

var gunBlast;
var whenIShit;

function onCreatePost()
{
	for (bitch in 0...fuckYouLegacy.length) if (PlayState.SONG.song == fuckYouLegacy[bitch]) layer = boyfriendGroup;

	baseY = parent.y;

	if (PlayState.SONG.song == 'Don\'t Lied') parent.y -= 30;

	gunBlast = FlxG.sound.load(Paths.sound('hankshoot', null, PathsTestMode.LOOSE));
	whenIShit = FlxG.sound.load(Paths.sound('kill', null, PathsTestMode.LOOSE));
}

function onBeatHit()
{
	if (!amongWalking && FlxG.random.bool())
	{
		var number = FlxG.random.int(0, colours.length - 1);

		color = colours[number];

		variance = FlxG.random.float(-350, 350);

		flip = (FlxG.random.bool() ? true : false);

		if (PlayState.SONG.song == 'Don\'t Lied')
		{
			flip = true;
			variance -= 1500;
		}

		var dist = (PlayState.SONG.song == 'Double Trouble' ? [1700, 2900] : [900, 2100]);

		var pos = (!flip ? [parent.x - dist[0], baseY + 210] : [parent.x + dist[1], baseY + 210]);

		willBeKilled = new FunkinSprite(pos[0], pos[1] + FlxG.random.float(-30, 30)).loadAtlas('${ext}walkers');
		willBeKilled.addAnimByPrefix('walk', '$color walk', 24, true);
		willBeKilled.addAnimByPrefix('idle', '$color idle', 24, false);
		stage.insert(stage.members.indexOf(layer) - 0, willBeKilled);
		willBeKilled.animation.play('walk', true);
		amongWalking = true;

		willBeKilled.flipX = flip;

	}

	if (amongWalking && !shouldWalk && curBeat % 2 == 0)
	{
		willBeKilled.animation.play('idle', false);
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (willBeKilled != null)
	{
		shouldWalk = FlxG.random.bool(0.5) ? !shouldWalk : shouldWalk;

		if (!shouldWalk && willBeKilled.getAnimName() == 'walk')
		{
			willBeKilled.animation.play('idle', true);
			regret = FlxG.random.bool(35);
		}

		if (shouldWalk && willBeKilled.getAnimName() == 'idle') willBeKilled.animation.play('walk', true);

		if (shouldWalk)
		{
			var speed = (elapsed * 333);

			willBeKilled?.x += speed * (flip ? -1 : 1) * (regret ? -1 : 1);

			if (regret)
			{
				distanceAway += speed;
				willBeKilled.flipX = !flip;
			}
			else if (!regret)
			{
				distanceAway = 0;
				willBeKilled.flipX = flip;
			}

			if (distanceAway >= 100) theKillFunction();
		}

		if (willBeKilled?.x >= (parent.x + variance) && !flip || willBeKilled?.x <= (parent.x + 1200 + variance) && flip)
		{
			theKillFunction();
		}
	}
}

function theKillFunction()
{
	var exclude = ((willBeKilled?.x < parent.x + 600) ? [1,2] : [3,4]);

	var numb = FlxG.random.int(1, 4, exclude);

	gunBlast.play(true);
	whenIShit.play(true);

	parent.playAnim('shoot$numb', true);
	parent.specialAnim = true;

	var ext2 = 'walkersDEATHS/';

	var bodyColor = ext2 + '${color}';

	var accidentalKill = FlxG.random.bool(2);

	var playerCanBeKilled = ((numb == 1 || numb == 2) && boyfriend.x > parent.x || (numb == 3 || numb == 4) && boyfriend.x < parent.x);

	if (accidentalKill && playerCanBeKilled)
	{
		FlxG.signals.postUpdate.addOnce(function() {
			health = -5; // get FUUUUUUUUUUUUUUUUUUUCKED
		});
	}
	else if (!accidentalKill || accidentalKill && !playerCanBeKilled)
	{
		var body = new FlxSprite(willBeKilled?.x + (willBeKilled?.flipX ? 130 : 50), willBeKilled?.y + 310);
		body.frames = Paths.getSparrowAtlas(bodyColor, null, null, PathsTestMode.LOOSE);
		body.animation.addByPrefix('death', 'dies', 24, false);
		stage.insert(stage.members.indexOf(layer) - 0, body);
		body.scale.set(0.8, 0.8);
		body.updateHitbox();
		body.flipX = !willBeKilled?.flipX;

		body.animation.play('death', true);

		willBeKilled.destroy();
		amongWalking = false;
		willBeKilled = null;
		regret = false;
	}
}

function onGameOver()
{
	if (willBeKilled != null)
	{
		willBeKilled.destroy();
		amongWalking = false;
		willBeKilled = null;
		regret = false;
	}
}