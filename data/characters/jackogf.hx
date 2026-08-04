function onCreatePost()
{
	nerdemoji = FlxG.random.bool(20);

	if (nerdemoji)
	{
		changeCharacter('jackonerd', 2);
	}
}