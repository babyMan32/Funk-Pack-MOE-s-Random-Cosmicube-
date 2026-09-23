function goodNoteHitPre(note)
{
	if (note.isSustainNote)
	{
		note.animSuffix = '-hold';
	}
}