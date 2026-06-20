function onUpdate(elapsed:Float):Void
{
	if (boyfriend.curCharacter == "bf-lava-dialogue" && boyfriend.shader != null)
	{
		boyfriend.shader = null;
	}
}