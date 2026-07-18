var womenIsFucked:Bool = false;

function onCreatePost()
{
	abot_dsides = new FlxSpriteGroup();
	gfGroup.insert(0, abot_dsides);

	a_bot_screen_dsides = new FlxSprite(50, 600).loadGraphic(Paths.image('characters/PicoSchool/Nene/ABotScreenFill', null, null, PathsTestMode.LOOSE));
	abot_dsides.add(a_bot_screen_dsides);

	a_bot_dsides = new FlxSprite(40, 300);
	a_bot_dsides.frames = Paths.getSparrowAtlas('characters/PicoSchool/Nene/ABotIdle', null, null, PathsTestMode.LOOSE);
	a_bot_dsides.animation.addByPrefix('idle', 'ABot', 24, false);
	abot_dsides.add(a_bot_dsides);

	abot_dsides.x = gf.x - 190;
	abot_dsides.y = gf.y - 20;

	if (FlxG.random.bool(10))
	{
		gf.idleSuffix = '-fucked';
		gf.recalculateDanceIdle();
		womenIsFucked = true;
	}
}

function onBeatHit()
{
	if (womenIsFucked)
	{
		if ((curBeat % 2 == 0) && gf.getAnimName() == 'idle-fucked')
		{
			gf.playAnim('idle-fucked', true);
			a_bot_dsides.animation.play('idle', true);
		}
	}
	else
	{
		a_bot_dsides.animation.play('idle', true);
	}
}

function onCountdownTick(tick)
{
	if (womenIsFucked)
	{
		if (tick % 2 == 0)
		{
			a_bot_dsides.animation.play('idle', true);
		}
	}
	else
	{
		a_bot_dsides.animation.play('idle', true);
	}
}