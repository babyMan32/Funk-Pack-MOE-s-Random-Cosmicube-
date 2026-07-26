function onLoad()
{
	if (PlayState.SONG.song == 'Drippypop (Remagets Mix)')
	{
		Paths.overrideMode = PathsTestMode.LOOSE;
	}
}

function onDestroy()
{
	if (Paths.overrideMode != null)
	{
		Paths.overrideMode = null;
	}
}

function onPause()
{
	if (PlayState.SONG.song != 'Drippypop (Remagets Mix)') return;

	Paths.overrideMode = PathsTestMode.LOOSE;
}

function onResume()
{
	if (PlayState.SONG.song != 'Drippypop (Remagets Mix)') return;

	if (Paths.overrideMode != null)
	{
		Paths.overrideMode = null;
	}
}