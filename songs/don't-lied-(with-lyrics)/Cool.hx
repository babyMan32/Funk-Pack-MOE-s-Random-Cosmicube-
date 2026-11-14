function onSpawnNote(note)
{
	if (note.lane == 1)
	{
		note.lane = 0;
		note.owner ??= dad;
	}
}