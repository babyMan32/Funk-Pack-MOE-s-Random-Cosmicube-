function onCreatePost()
{
	if (curSong != 'Identity Crisis') return;

	playFields.members[0].isPlayer = false;
	playFields.members[0].playerControls = false;
	playFields.members[0].autoPlayed = true;
	playFields.members[0].noteSplashes = false;

	playFields.members[1].isPlayer = true;
	playFields.members[1].playerControls = true;
	playFields.members[1].autoPlayed = false;
	playFields.members[1].noteSplashes = true;
}

function onStepHit()
{
	if (curSong != 'Identity Crisis') return;

	if (curStep == 383)
	{
		playFields.members[0].isPlayer = true;
		playFields.members[0].playerControls = true;
		playFields.members[0].autoPlayed = cpuControlled;
		playFields.members[0].noteSplashes = true;

		playFields.members[1].isPlayer = false;
		playFields.members[1].playerControls = false;
		playFields.members[1].autoPlayed = true;
		playFields.members[1].noteSplashes = false;
	}
}