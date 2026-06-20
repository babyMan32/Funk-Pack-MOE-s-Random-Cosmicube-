function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'bf-air' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('hey');

		if (FlxG.random.bool(20))
		{
			boyfriend.playAnim('cheer');
		}

		boyfriend.specialAnim = true;
		boyfriend.holding = true;
	}
}