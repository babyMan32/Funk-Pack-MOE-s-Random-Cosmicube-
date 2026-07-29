var dontlaugh = false;

function onCreatePost()
{
	if (FlxG.random.bool(10))
	{
		dontlaugh = true;
		boyfriend.canTaunt = false;
		boyfriend.playAnim('whyyoutryingnottolaughbruh', true);
		boyfriend.stunned = true;
	}
}

function onSpawnNote(note)
{
	if (note.lane != 0) return;
		
	if (!dontlaugh) return;

	note.ignoreNote = true;
}