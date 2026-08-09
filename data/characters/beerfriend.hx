function onUpdatePost(elapsed:Float):Void
{
	if (boyfriend.curCharacter != 'beerfriend') return;

	if (FlxG.random.bool((1 / 120) * 100))
	{
		boyfriend.stunned = true;
	}

	if (FlxG.random.bool((1 / 30) * 100))
	{
		boyfriend.stunned = false;
	}
}