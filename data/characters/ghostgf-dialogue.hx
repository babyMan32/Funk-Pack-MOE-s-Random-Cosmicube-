function onCreatePost()
{
	if (PlayState.SONG.stage != 'polus') return;

	if (gf.curCharacter != 'ghostgf-dialogue') return;

	FlxG.signals.postUpdate.addOnce(function() {
		speaker.alpha = 1;
	});

	if (PlayState.SONG.song != 'Sabotage') return;

	gf.alpha = 0.001;
}

function gfSpawn()
{
	gf.alpha = 1;
}

function onEvent(n, v1, v2)
{
	if (n == 'Legacy')
	{
		switch (v1)
		{
			case 'GF Appear':
				gf.alpha = 1;

			case 'sabotage notice':
				FlxTimer.wait(0.1, gfSpawn);
				dad.playAnim('ayo', true);
				dad.stunned = true;
				gf.playAnim('cheer', true);
				gf.stunned = true;

			case 'sabotage back':
				dad.stunned = false;
				gf.stunned = false;
		}
	}
}