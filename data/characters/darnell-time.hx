function onStepHit()
{
	switch (PlayState.SONG.song)
	{
		case 'Evil Defeat Alkamix':
			switch (curStep)
			{
				case 1727:
					boyfriend.idleSuffix = '-scared';
					boyfriend.animSuffix = '-scared';
			}
	}
}

function goodNoteHitPre(note)
{
	note.animSuffix = boyfriend.animSuffix;
}