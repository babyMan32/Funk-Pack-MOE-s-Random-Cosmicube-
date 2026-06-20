function onCreatePost() //making this a variant flag still gives him a shader sooooo
{
	switch (PlayState.SONG.stage)
	{
		case "boiling":
			changeCharacter("bf-lava-dialogue", 0);
	}
}