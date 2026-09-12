function onBeatHit()
{
	if (curSong != 'Identity Crisis') return;

	switch (curBeat)
	{
		case 8:
			changeCharacter('pico-dopple-playable', 0);
			changeCharacter('pico-dopple-opponent', 1);

			playShoot = FlxG.random.bool();
			boom = FlxG.random.bool(8);
			killedPlay = false;
			killedOpp = false;

			if (playShoot)
			{
				boyfriend.playAnim('intro-shoot');
				dad.playAnim(boom ? 'intro-death' : 'intro');
				killedOpp = boom;

				dad.animation.onFinish.add((animName) -> {
					if (animName == 'intro-death')
					{
						dad.animation.play('death', true);
					}
				});
			}
			else
			{
				boyfriend.playAnim(boom ? 'intro-death' : 'intro');
				dad.playAnim('intro-shoot');
				killedPlay = boom;

				boyfriend.animation.onFinish.add((animName) -> {
					if (animName == 'intro-death')
					{
						boyfriend.animation.play('death', true);
					}
				});
			}

		case 46:
			if (!killedPlay) changeCharacter('pico-playable', 0);
			if (!killedOpp) changeCharacter('pico', 1);
	}
}