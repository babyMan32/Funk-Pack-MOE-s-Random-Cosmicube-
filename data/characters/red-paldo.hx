var crashing = false;

function onUpdatePost(elapsed:Float):Void
{
	if (controls.NOTE_TAUNT_P && !crashing)
	{
		game.persistentUpdate = false;
		game.persistentDraw = true;
		FlxG.camera.followLerp = 0;
		game.audio?.pause();
		game.paused = true;
		canPause = false;
		crashing = true;

		Paths.overrideMode = PathsTestMode.LOOSE;
		openSubState(new ScriptedSubstate('CrashSubState'));
	}
}