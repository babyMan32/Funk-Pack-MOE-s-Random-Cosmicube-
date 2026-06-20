function onLoad()
{
	if (hasBfSkin)
	{
		switch (PlayState.SONG.song)
		{
			case "Defeat", "Finale":
				boyfriend.idleSuffix = '-angry';
				boyfriend.animSuffix = '-angry';
		}
	}
}