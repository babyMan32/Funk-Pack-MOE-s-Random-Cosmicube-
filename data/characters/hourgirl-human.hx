var time = 0;

function onLoad()
{
	time = (0.05 * (FlxG.random.bool() ? -1 : 1));

	playbackRate += time;
}

function onUpdate(elapsed:Float):Void
{
	if (ClientPrefs.inDevMode || PlayState.chartingMode)
	{
		if (FlxG.keys.pressed.THREE)
		{
			playbackRate += time * (FlxG.keys.pressed.SHIFT ? 0.5 : 2);
		}
		else if (FlxG.keys.justReleased.THREE)
		{
			playbackRate += time;
		}
	}
}