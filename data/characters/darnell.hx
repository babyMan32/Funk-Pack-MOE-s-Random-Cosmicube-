using StringTools;

var ext = 'darnell/';

var prep;
var kick_up;
var knee_forward;
var bonk;

var yollowExploding = ['D\'low', 'D\'low (Pico Mix)'];

function onCreatePost()
{
	explodeYellow = new FlxSprite(0, 0);
	explodeYellow.frames = Paths.getSparrowAtlas(ext + 'SpraypaintExplosion', null, null, PathsTestMode.LOOSE);
	explodeYellow.animation.addByPrefix('boom', 'Explosion 1 movie', 24, false);
	add(explodeYellow);

	explodeYellow.alpha = 0.00000001;
	explodeYellow.x = dad.x - 250;
	explodeYellow.y = dad.y - 200;

	explodeYellow.animation.onFinish.add((animName) -> {
		if (animName == 'boom')
			explodeYellow.alpha = 0.00000001;
	});

	canUp = new FlxSprite(0, 0);
	canUp.frames = Paths.getSparrowAtlas(ext + 'wked1_cutscene_1_can', null, null, PathsTestMode.LOOSE);
	canUp.animation.addByPrefix('up', 'can kicked up', 24, false);
	canUp.flipX = true;
	add(canUp);

	canKick = new FlxSprite(0, 0);
	canKick.frames = Paths.getSparrowAtlas(ext + 'wked1_cutscene_1_can', null, null, PathsTestMode.LOOSE);
	canKick.animation.addByPrefix('to', 'can kick quick', 24, false);
	canKick.flipX = true;
	add(canKick);

	canUp.alpha = 0.00000001;
	canUp.x = boyfriend.x + 180;
	canUp.y = boyfriend.y + 50;

	canKick.alpha = 0.00000001;
	canKick.x = boyfriend.x - 620;
	canKick.y = boyfriend.y + 160;
	canKick.animation.play('to', true);

	canKick.animation.onFinish.add((animName) -> {
		if (animName == 'to')
			canKick.alpha = 0.00000001;
	});

	prep = FlxG.sound.load(Paths.sound(ext + 'Darnell_Lighter', null, PathsTestMode.LOOSE));
	kick_up = FlxG.sound.load(Paths.sound(ext + 'Kick_Can_UP', null, PathsTestMode.LOOSE));
	knee_forward = FlxG.sound.load(Paths.sound(ext + 'Kick_Can_FORWARD', null, PathsTestMode.LOOSE));
	bonk = FlxG.sound.load(Paths.sound(ext + 'Pico_Bonk', null, PathsTestMode.LOOSE));
}

function goodNoteHitPre(note)
{
	if (!yollowExploding.contains(PlayState.SONG.song)) return;

	if (curStep >= 1415)
	{
		note.noAnimation = true;
	}
}

function onStepHit()
{
	if (!yollowExploding.contains(PlayState.SONG.song)) return;

	if (curStep == 1415)
	{
		prep.play();
	}

	if (curStep == 1419)
	{
		kick_up.play();
	}

	if (curStep == 1423)
	{
		boyfriend.playAnim('punt-can', true);
		boyfriend.specialAnim = true;
		knee_forward.play();

		canKick.alpha = 1;
		canUp.alpha = 0.00000001;
		canKick.animation.play('to', true);
	}
}

function onBeatHit()
{
	if (!yollowExploding.contains(PlayState.SONG.song)) return;

	if (curBeat == 354)
	{
		boyfriend.playAnim('can-prep', true);
		boyfriend.specialAnim = true;
	}

	if (curBeat == 355)
	{
		boyfriend.playAnim('kick-up', true);
		boyfriend.specialAnim = true;

		canUp.alpha = 1;
		canUp.animation.play('up', true);
	}

	if (curBeat == 356)
	{
		bonk.play();

		explodeYellow.alpha = 1;
		explodeYellow.animation.play('boom');
	}
}