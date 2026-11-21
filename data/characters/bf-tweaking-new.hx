function goodNoteHit(note)
{
	if (note.noteType == 'Hooray')
	{
		if (!note.isSustainNote)
		{
			boyfriend.playAnim('cheer', true);
			boyfriend.specialAnim = true;
		}
	}
}

function onSpawnNote(note)
{
	if (note.noteType == 'Hooray')
	{
		if (note.isSustainNote)
		{
			note.noAnimation = true;
		}
	}
}