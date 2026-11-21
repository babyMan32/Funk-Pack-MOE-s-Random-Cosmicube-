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

var number = 0;

var gunBlast;
var whenIShit;

var walkingFuckers = [];
var deadFuckers = [];

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
		number = FlxG.random.int(0, colours.length - 1);

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

		walkingFuckers.push(willBeKilled);
	}

	for (i in 0...walkingFuckers.length)
	{
		if (amongWalking && !shouldWalk && curBeat % 2 == 0)
		{
			walkingFuckers[i]?.animation.play('idle', false);
		}
	}
}

function onUpdatePost(elapsed:Float):Void
{
	for (i in 0...walkingFuckers.length)
	{
		if (walkingFuckers != null)
		{
			shouldWalk = FlxG.random.bool(0.5) ? !shouldWalk : shouldWalk;

			if (!shouldWalk && walkingFuckers[i]?.getAnimName() == 'walk')
			{
				walkingFuckers[i]?.animation.play('idle', true);
				regret = FlxG.random.bool(35);
			}

			if (shouldWalk && walkingFuckers[i]?.getAnimName() == 'idle') walkingFuckers[i]?.animation.play('walk', true);

			if (shouldWalk)
			{
				var speed = (elapsed * 333);

				walkingFuckers[i]?.x += speed * (flip ? -1 : 1) * (regret ? -1 : 1);

				if (regret)
				{
					distanceAway += speed;
					walkingFuckers[i]?.flipX = !flip;
				}
				else if (!regret)
				{
					distanceAway = 0;
					walkingFuckers[i]?.flipX = flip;
				}

				if (distanceAway >= 100) theKillFunction(walkingFuckers[i]);
			}

			if (walkingFuckers[i]?.x >= (parent.x + variance) && !flip || walkingFuckers[i]?.x <= (parent.x + 1200 + variance) && flip)
			{
				theKillFunction(walkingFuckers[i], i);
			}
		}
	}
}

function theKillFunction(person, index)
{
	var exclude = ((person?.x < parent.x + 600) ? [1,2] : [3,4]);

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
		var body = new FlxSprite(person?.x + (person?.flipX ? 130 : 50), person?.y + 310);
		body.frames = Paths.getSparrowAtlas(bodyColor, null, null, PathsTestMode.LOOSE);
		body.animation.addByPrefix('death', 'dies', 24, false);
		stage.insert(stage.members.indexOf(layer) - 0, body);
		body.scale.set(0.8, 0.8);
		body.updateHitbox();
		body.flipX = !person?.flipX;

		body.animation.play('death', true);

		walkingFuckers[index].destroy();
		walkingFuckers[index] = null;
		amongWalking = false;
		regret = false;

		deadFuckers.push(body);
	}
}

function onGameOver()
{
	if (walkingFuckers != null)
	{
		walkingFuckers.destroy();
		walkingFuckers = null;
		amongWalking = false;
		regret = false;
	}
}