var amongWalking = false;

var willBeKilled;

var flip = false;

var ext = 'stages/mira/cafeteria/';

var color = 'lime';
var colours = ['blue', 'lime', 'tan', 'white', 'yellow', 'brown'];

function onBeatHit()
{
	if (!amongWalking && FlxG.random.bool())
	{
		color = colours[FlxG.random.int(0, colours.length)];

		flip = (FlxG.random.bool() ? true : false);

		var pos = (!flip ? [gf.x - 700, gf.y + 210] : [gf.x + 1900, gf.y + 210]);

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
}

function onUpdatePost(elapsed:Float):Void
{
	if (willBeKilled?.visible)
	{
		willBeKilled.x += (elapsed * 333) * (flip ? -1 : 1);

		if (willBeKilled?.x >= (gf.x + FlxG.random.float(-100, 100)) && !flip || willBeKilled?.x <= (gf.x + 1200 + FlxG.random.float(-100, 100)) && flip)
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