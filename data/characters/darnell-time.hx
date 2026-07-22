function onStepHit()
{
	switch (PlayState.SONG.song)
	{
		case 'Evil Defeat Alkamix':
			switch (curStep)
			{
				case 1728:
					boyfriend.idleSuffix = '-scared';
					boyfriend.animSuffix = '-scared';
			}
	}
}