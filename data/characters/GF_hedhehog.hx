function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "danger":
			gf.x -= 40;
			gf.y += 10;
	}
}