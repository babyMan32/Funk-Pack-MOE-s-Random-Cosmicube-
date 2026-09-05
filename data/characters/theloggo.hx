var theloggo = false;

function onCreatePost()
{
	if (FlxG.random.bool())
	{
		boyfriend.shader = null;
	}

	if (FlxG.random.bool(25))
	{
		comboX = 440;
		theloggo = true;
		boyfriend.shader = null;
		opponentStrums.visible = false;
		changeCharacter('theloggopponent', 1);
		playFields.members[1].isPlayer = true;
		playFields.members[1].autoPlayed = false;
		modManager.setValue('opponentSwap', 0.5);
		playFields.members[1].noteSplashes = true;
		playFields.members[1].playerControls = true;
	}
}

function goodNoteHit(note)
{
	if (note.owner == dad)
	{
		opponentNoteHit(note);
	}
}

function onUpdatePost(elapsed:Float):Void
{
	if (!theloggo) return;

	if (getSongTime() >= 60000)
	{
		health = 0;
	}
}