function onStepHit()
{
	switch (PlayState.SONG.song)
	{
		case 'Evil Defeat Alkamix':
			switch (curStep)
			{
				case 407:
					triggerEventNote('Alt Idle Animation', 'gf', '-alt');

				case 1183:
					triggerEventNote('Alt Idle Animation', 'gf', '');

				case 1456, 1464:
					gf.playAnim('idle-alt', true);

				case 1460, 1468:
					gf.playAnim('idle', true);

				case 1472:
					gf.playAnim('idle-alt', true);
					triggerEventNote('Alt Idle Animation', 'gf', '-alt');

				case 1728:
					gf.playAnim('shock', true);
					triggerEventNote('Alt Idle Animation', 'gf', '-alt2');
			}
	}
}