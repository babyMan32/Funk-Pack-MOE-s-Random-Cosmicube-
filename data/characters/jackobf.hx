function onCreatePost()
{
	pump = FlxG.random.bool(6.2);

	if (pump)
	{
		boyfriend.idleSuffix = '-alt';
		boyfriend.recalculateDanceIdle();
		boyfriend.playAnim('idle-alt', true);
	}
}