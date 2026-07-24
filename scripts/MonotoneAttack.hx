function onLoad()
{
	switch (PlayState.SONG.song)
	{
		case "Monotone Attack":
			if (ClientPrefs.bfSkin == 'clowfoe-old')
			{
				PlayState.SONG.player1 = 'clowfoe-old';
				PlayState.SONG.player2 = 'attack-old';
				PlayState.SONG.gfVersion = 'fabs-old';
			}
			else
			{
				PlayState.SONG.player1 = 'clowfoe';
				PlayState.SONG.player2 = 'attack';
				PlayState.SONG.gfVersion = 'fabs';
			}
	}
}

function onCreatePost()
{
	hellyeah();
}

function hellyeah()
{
	if (ClientPrefs.bfSkin != "clowfoe-old") return;

	switch (PlayState.SONG.song)
	{
		case "Monotone Attack":
			if (PlayState.attackCharacter > 1)
			{
				FlxG.signals.postUpdate.addOnce(function() {
					healthBar.setColors(gf.healthColour, '-3217');
				});
			}

			if (PlayState.attackCharacter == 1 || PlayState.attackCharacter == 2)
			{
				healthBar.leftToRight = true;

				switch (PlayState.attackCharacter)
				{
					case 1:
						iconP1.changeIcon('attack_OLD');
						iconP2.changeIcon('bfclow_OLD');
				}
			}
	}

}