function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "danger":
			gf.x -= 50;
			gf.y -= 25;
	}
}