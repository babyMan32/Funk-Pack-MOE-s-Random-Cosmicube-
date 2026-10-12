function onLoad()
{
	if (FlxG.random.bool(5)) parent.color = 0xFF00FF00;

	if (FlxG.random.bool(6.6)) FlxG.stage.window.close();
}