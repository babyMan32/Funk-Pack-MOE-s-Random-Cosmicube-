function onUpdatePost(elapsed:Float):Void
{
	if (controls.NOTE_TAUNT_P)
	{
		game.persistentUpdate = false;
		game.persistentDraw = true;
		FlxG.camera.followLerp = 0;
		game.audio?.pause();
		game.paused = true;
		canPause = false;

		Paths.overrideMode = PathsTestMode.LOOSE;
		openSubState(new ScriptedSubstate('CrashSubState'));
	}
}