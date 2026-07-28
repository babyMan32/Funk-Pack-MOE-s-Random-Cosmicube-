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

		case "Drippypop":
			if (ClientPrefs.bfSkin == 'clowfoe-old')
			{
				PlayState.SONG.player2 = 'drippypop-old';
			}
			else
			{
				PlayState.SONG.player2 = 'drippypop';
			}
	}
}

function onCreatePost()
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

			if (PlayState.attackCharacter == 1)
			{
				iconP1.changeIcon('attack_OLD');
				iconP2.changeIcon('bfclow_OLD');
			}
	}
}

function onPause()
{
	if (ClientPrefs.bfSkin != "clowfoe-old") return;

	switch (PlayState.SONG.song)
	{
		case "Monotone Attack":
			Paths.overrideMode = PathsTestMode.LOOSE;
			pauseOverwrite = 'attack-old';
	}
}

function onResume()
{
	if (ClientPrefs.bfSkin != "clowfoe-old") return;

	if (Paths.overrideMode != null)
	{
		Paths.overrideMode = null;
	}
}