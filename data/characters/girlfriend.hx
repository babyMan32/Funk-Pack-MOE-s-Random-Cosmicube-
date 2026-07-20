function onCreatePost()
{
	switch (PlayState.SONG.stage)
	{
		case "danger":
			changeCharacter('girlfriend-wind', 2);

			gf.x -= 50;
			gf.y -= 25;
	}
}