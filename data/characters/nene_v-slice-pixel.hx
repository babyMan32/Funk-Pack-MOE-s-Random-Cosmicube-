var ext = 'characters/neneshit/abotPixel/';
var lookingLeft = false;

var hdChance = false;

function onCreatePost()
{
	hdChance = FlxG.random.bool(20);

	gf.antialiasing = (hdChance ? true : false); //hd chance

	abotPixel = new FlxSpriteGroup();
	gfGroup.insert(0, abotPixel);

	a_bot_headPixel = new FlxSprite(-650, 560);
	a_bot_headPixel.frames = Paths.getSparrowAtlas(ext + 'abotHead', null, null, PathsTestMode.LOOSE);
	a_bot_headPixel.animation.addByPrefix('toleft', 'toleft', 24, false);
	a_bot_headPixel.animation.addByPrefix('left', 'left', 24, false);
	a_bot_headPixel.animation.addByPrefix('toright', 'toright', 24, false);
	a_bot_headPixel.animation.addByPrefix('right', 'right', 24, false);
	a_bot_headPixel.antialiasing = (hdChance ? true : false);
	a_bot_headPixel.scale.set(6, 6);
	abotPixel.add(a_bot_headPixel);

	a_bot_screenPixel = new FlxSprite(-390, 500).loadGraphic(Paths.image('${ext}aBotPixelBack', null, null, PathsTestMode.LOOSE));
	a_bot_screenPixel.antialiasing = (hdChance ? true : false);
	a_bot_screenPixel.scale.set(6, 6);
	abotPixel.add(a_bot_screenPixel);

	a_botPixel = new FlxSprite(-410, 500);
	a_botPixel.frames = Paths.getSparrowAtlas(ext + 'aBotPixel', null, null, PathsTestMode.LOOSE);
	a_botPixel.animation.addByPrefix('idle', 'idle', 24, false);
	a_botPixel.antialiasing = (hdChance ? true : false);
	a_botPixel.scale.set(6, 6);
	abotPixel.add(a_botPixel);

	abotPixel.x = gf.x + 530;
	abotPixel.y = gf.y - 280;

	lookLeft();
}

function onBeatHit()
{
	a_botPixel.animation.play('idle', true);
}

function onCountdownTick(tick)
{
	a_botPixel.animation.play('idle', true);
}

function onSectionHit()
{
	if (mustHitSection)
	{
		if (lookingLeft)
		{
			lookRight();
		}
	}
	else
	{
		if (!lookingLeft)
		{
			lookLeft();
		}
	}
}

function lookLeft()
{
	lookingLeft = true;
	a_bot_headPixel.animation.play('toleft', true);

	a_bot_headPixel.animation.onFinish.add((animName) -> {
		if (animName == 'toleft')
			a_bot_headPixel.animation.play('left', true);
	});
}

function lookRight()
{
	lookingLeft = false;
	a_bot_headPixel.animation.play('toright', true);

	a_bot_headPixel.animation.onFinish.add((animName) -> {
		if (animName == 'toright')
			a_bot_headPixel.animation.play('right', true);
	});
}