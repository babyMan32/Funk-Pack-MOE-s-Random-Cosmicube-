var amongWalking = false;

var willBeKilled;

var flip = false;

var ext = 'stages/mira/cafeteria/';

var color = 'lime';
var colours = ['blue', 'lime', 'tan', 'white', 'yellow', 'brown'];

var exclusions = [
	['jorsawsee', 'blue'],
	['LIMEGREENWEEKINVSIMPOSTOR', 'lime'],
	['white', 'white'],
	['whitedk', 'white'],
	['yellow', 'yellow']
];

var variance = 0;

var shouldWalk = true;

function onBeatHit()
{
	if (!amongWalking && FlxG.random.bool())
	{
		var number = FlxG.random.int(0, colours.length - 1);

		color = colours[number];

		variance = FlxG.random.float(-350, 350);

		for (i in 0...exclusions.length)
		{
			if (dad.curCharacter == exclusions[i][0] && color == exclusions[i][1]) color = colours[number + (FlxG.random.bool() ? 1 : -1)];

			if (PlayState.SONG.song == 'Oversight' && color == 'yellow') color = colours[number + (FlxG.random.bool() ? 1 : -2)];
		}

		flip = (FlxG.random.bool() ? true : false);

		var pos = (!flip ? [gf.x - 900, gf.y + 210] : [gf.x + 2100, gf.y + 210]);

		willBeKilled = new FunkinSprite(pos[0], pos[1] + FlxG.random.float(-30, 30)).loadAtlas('${ext}walkers');
		willBeKilled.addAnimByPrefix('walk', '$color walk', 24, true);
		willBeKilled.addAnimByPrefix('idle', '$color idle', 24, false);
		stage.insert(stage.members.indexOf(dadGroup) - 0, willBeKilled);
		willBeKilled.visible = false;
		amongWalking = true;

		willBeKilled.flipX = flip;

		new FlxTimer().start(0.1, () -> {
			willBeKilled.animation.play('walk', true);
			willBeKilled.visible = true;
		});
	}

	if (amongWalking && !shouldWalk && curBeat % 2 == 0)
	{
		willBeKilled.animation.play('idle', false);
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (willBeKilled?.visible)
	{
		shouldWalk = FlxG.random.bool(0.5) ? !shouldWalk : shouldWalk;

		if (!shouldWalk && willBeKilled.getAnimName() == 'walk') willBeKilled.animation.play('idle', true);

		if (shouldWalk && willBeKilled.getAnimName() == 'idle') willBeKilled.animation.play('walk', true);

		if (shouldWalk) willBeKilled?.x += (elapsed * 333) * (flip ? -1 : 1);

		if (willBeKilled?.x >= (gf.x + variance) && !flip || willBeKilled?.x <= (gf.x + 1200 + variance) && flip)
		{
			var exclude = (!flip ? [1,2] : [3,4]);

			var numb = FlxG.random.int(1, 4, exclude);

			parent.playAnim('shoot$numb', true);
			parent.specialAnim = true;

			var body = new FlxSprite(willBeKilled?.x, willBeKilled?.y + 450).loadGraphic(Paths.image('stages/airship/mando/YELLOW', null, null, PathsTestMode.LOOSE));
			stage.insert(stage.members.indexOf(dadGroup) - 0, body);
			body.flipX = flip;

			willBeKilled.destroy();
			amongWalking = false;
			willBeKilled = null;
		}
	}
}