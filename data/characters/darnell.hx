var ext = 'darnell/';

var prep;
var kick_up;
var knee_forward;
var bonk;

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

	prep = FlxG.sound.load(Paths.sound(ext + 'Darnell_Lighter', null, PathsTestMode.LOOSE));
	kick_up = FlxG.sound.load(Paths.sound(ext + 'Kick_Can_UP', null, PathsTestMode.LOOSE));
	knee_forward = FlxG.sound.load(Paths.sound(ext + 'Kick_Can_FORWARD', null, PathsTestMode.LOOSE));
	bonk = FlxG.sound.load(Paths.sound(ext + 'Pico_Bonk', null, PathsTestMode.LOOSE));
}

function goodNoteHitPre(note)
{
	if (PlayState.SONG.song != 'D\'low') return;

	if (curStep >= 1415)
	{
		note.noAnimation = true;
	}
}

function onBeatHit()
{
	if (PlayState.SONG.song != 'D\'low') return;

	if (curBeat == 354)
	{
		boyfriend.playAnim('can-prep', true);
		boyfriend.specialAnim = true;
		prep.play();
	}

	if (curBeat == 355)
	{
		boyfriend.playAnim('kick-up', true);
		boyfriend.specialAnim = true;
		kick_up.play();
	}

	if (curBeat == 356)
	{
		boyfriend.playAnim('punt-can', true);
		boyfriend.specialAnim = true;
		knee_forward.play();
		bonk.play();

		explodeYellow.alpha = 1;
		explodeYellow.animation.play('boom');
	}
}